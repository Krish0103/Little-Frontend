<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .menu-item-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .menu-item-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .price-tag {
            font-size: 1.2rem;
            font-weight: bold;
            color: #28a745;
        }
        .category-filter {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50px;
        }
        .filter-btn {
            border: 2px solid transparent;
            transition: all 0.3s;
        }
        .filter-btn.active {
            background-color: #667eea;
            color: white;
            border-color: #667eea;
        }
        .food-image {
            height: 200px;
            object-fit: cover;
        }
        .dietary-badge {
            font-size: 0.75rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h2 class="display-6 mb-2">
                    <i class="fas fa-utensils text-primary me-2"></i>Our Menu
                </h2>
                <p class="text-muted">Discover delicious food from the best restaurants</p>
            </div>
            <div class="col-md-4 text-md-end">
                <div class="btn-group" role="group">
                    <input type="radio" class="btn-check" name="sortBy" id="sortPrice" value="price">
                    <label class="btn btn-outline-primary btn-sm" for="sortPrice">
                        <i class="fas fa-sort-amount-up me-1"></i>Price
                    </label>
                    <input type="radio" class="btn-check" name="sortBy" id="sortRating" value="rating" checked>
                    <label class="btn btn-outline-primary btn-sm" for="sortRating">
                        <i class="fas fa-star me-1"></i>Popular
                    </label>
                </div>
            </div>
        </div>

        <!-- Category Filters -->
        <div class="row mb-4">
            <div class="col">
                <div class="d-flex flex-wrap gap-2">
                    <button class="btn filter-btn active" data-category="all">
                        <i class="fas fa-th-large me-1"></i>All Items
                    </button>
                    <button class="btn filter-btn" data-category="Pizza">
                        <i class="fas fa-pizza-slice me-1"></i>Pizza
                    </button>
                    <button class="btn filter-btn" data-category="Burger">
                        <i class="fas fa-hamburger me-1"></i>Burgers
                    </button>
                    <button class="btn filter-btn" data-category="Indian">
                        <i class="fas fa-pepper-hot me-1"></i>Indian
                    </button>
                    <button class="btn filter-btn" data-category="Chinese">
                        <i class="fas fa-dragon me-1"></i>Chinese
                    </button>
                    <button class="btn filter-btn" data-category="Dessert">
                        <i class="fas fa-ice-cream me-1"></i>Desserts
                    </button>
                    <button class="btn filter-btn" data-filter="vegetarian">
                        <i class="fas fa-leaf text-success me-1"></i>Vegetarian
                    </button>
                    <button class="btn filter-btn" data-filter="vegan">
                        <i class="fas fa-seedling text-success me-1"></i>Vegan
                    </button>
                </div>
            </div>
        </div>

        <!-- Success/Error/Info Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty info}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="fas fa-info-circle me-2"></i>${info}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Menu Items Grid -->
        <div class="row" id="menuItemsContainer">
            <c:choose>
                <c:when test="${not empty menuItems}">
                    <c:forEach var="item" items="${menuItems}">
                        <div class="col-lg-4 col-md-6 mb-4 menu-item" 
                             data-category="${item.category}" 
                             data-vegetarian="${item.vegetarian}"
                             data-vegan="${item.vegan}"
                             data-price="${item.price}">
                            <div class="card menu-item-card border-0 shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" class="card-img-top food-image" alt="${item.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card-img-top food-image bg-light d-flex align-items-center justify-content-center">
                                            <i class="fas fa-utensils text-muted" style="font-size: 3rem;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="card-title mb-0">${item.name}</h5>
                                        <div class="d-flex gap-1">
                                            <c:if test="${item.vegetarian}">
                                                <span class="badge bg-success dietary-badge">
                                                    <i class="fas fa-leaf"></i> Veg
                                                </span>
                                            </c:if>
                                            <c:if test="${item.vegan}">
                                                <span class="badge bg-success dietary-badge">
                                                    <i class="fas fa-seedling"></i> Vegan
                                                </span>
                                            </c:if>
                                            <c:if test="${item.glutenFree}">
                                                <span class="badge bg-info dietary-badge">
                                                    <i class="fas fa-check"></i> GF
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <p class="card-text text-muted mb-2">${item.description}</p>
                                    
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="text-muted small">
                                            <i class="fas fa-store me-1"></i>${item.restaurantName}
                                        </span>
                                        <span class="badge bg-primary">${item.category}</span>
                                    </div>
                                    
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div>
                                            <span class="price-tag">₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span>
                                            <c:if test="${item.preparationTime > 0}">
                                                <small class="text-muted ms-2">
                                                    <i class="fas fa-clock me-1"></i>${item.preparationTime} min
                                                </small>
                                            </c:if>
                                        </div>
                                        <div class="rating text-warning">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                            <small class="text-muted ms-1">4.2</small>
                                        </div>
                                    </div>
                                    
                                    <c:choose>
                                        <c:when test="${item.available}">
                                            <form class="add-to-cart-form" data-item-id="${item.id}">
                                                <!-- Hidden input for menu item ID -->
                                                <input type="hidden" name="menuItemId" value="${item.id}" />
                                                <!-- DEBUG: Item ID = ${item.id} -->
                                                <div class="row align-items-center">
                                                    <div class="col-4">
                                                        <select class="form-select form-select-sm" name="quantity">
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-8">
                                                        <button type="submit" class="btn btn-primary btn-sm w-100" data-debug-id="${item.id}">
                                                            <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-secondary btn-sm w-100" disabled>
                                                <i class="fas fa-times me-1"></i>Currently Unavailable
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-utensils text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3 text-muted">No menu items found</h3>
                            <p class="text-muted">Try adjusting your search or filter criteria</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Load More Button (for pagination) -->
        <div class="row mt-4">
            <div class="col text-center">
                <button class="btn btn-outline-primary btn-lg" id="loadMoreBtn" style="display: none;">
                    <i class="fas fa-plus me-2"></i>Load More Items
                </button>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Category filtering
        document.querySelectorAll('.filter-btn').forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
                // Add active class to clicked button
                this.classList.add('active');
                
                const category = this.dataset.category;
                const filter = this.dataset.filter;
                
                filterMenuItems(category, filter);
            });
        });

        function filterMenuItems(category, filter) {
            const menuItems = document.querySelectorAll('.menu-item');
            
            menuItems.forEach(item => {
                let show = true;
                
                if (category && category !== 'all') {
                    show = item.dataset.category === category;
                } else if (filter === 'vegetarian') {
                    show = item.dataset.vegetarian === 'true';
                } else if (filter === 'vegan') {
                    show = item.dataset.vegan === 'true';
                }
                
                if (show) {
                    item.style.display = 'block';
                    item.classList.add('fade-in');
                } else {
                    item.style.display = 'none';
                    item.classList.remove('fade-in');
                }
            });
        }

        // Add to cart functionality
        document.querySelectorAll('.add-to-cart-form').forEach(form => {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Create FormData from the form (this will include all form fields including hidden inputs)
                const formData = new FormData(this);
                const itemId = formData.get('menuItemId');
                const quantity = formData.get('quantity');
                const button = this.querySelector('button[type="submit"]');
                
                console.log('DEBUG: FormData menuItemId:', itemId);
                console.log('DEBUG: FormData quantity:', quantity);
                console.log('DEBUG: Form element:', this);
                
                if (!itemId || itemId.trim() === '') {
                    console.error('ERROR: itemId is empty or null');
                    alert('Error: Could not identify the menu item. Please refresh the page and try again.');
                    return;
                }
                
                // Show loading state
                button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Adding...';
                button.disabled = true;
                
                console.log('DEBUG: Sending menuItemId:', itemId, 'quantity:', quantity);
                
                // Send AJAX request with FormData
                fetch('${pageContext.request.contextPath}/menu/add-to-cart', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    console.log('DEBUG: Server response:', data);
                    if (data === 'success') {
                        // Show success message
                        button.innerHTML = '<i class="fas fa-check me-1"></i>Added!';
                        button.classList.remove('btn-primary');
                        button.classList.add('btn-success');
                        
                        // Reset button after 2 seconds
                        setTimeout(() => {
                            button.innerHTML = '<i class="fas fa-cart-plus me-1"></i>Add to Cart';
                            button.classList.remove('btn-success');
                            button.classList.add('btn-primary');
                            button.disabled = false;
                        }, 2000);
                        
                        // Update cart badge (if exists)
                        updateCartBadge();
                    } else {
                        console.log('DEBUG: Server returned error:', data);
                        throw new Error('Failed to add item: ' + data);
                    }
                })
                .catch(error => {
                    console.error('DEBUG: Catch block error:', error);
                    // Show error state
                    button.innerHTML = '<i class="fas fa-exclamation-triangle me-1"></i>Error';
                    button.classList.remove('btn-primary');
                    button.classList.add('btn-danger');
                    
                    // Reset button after 2 seconds
                    setTimeout(() => {
                        button.innerHTML = '<i class="fas fa-cart-plus me-1"></i>Add to Cart';
                        button.classList.remove('btn-danger');
                        button.classList.add('btn-primary');
                        button.disabled = false;
                    }, 2000);
                });
            });
        });

        function updateCartBadge() {
            // This would typically make an AJAX call to get current cart count
            // For now, we'll just increment the visible badge
            const badge = document.querySelector('.navbar .badge');
            if (badge) {
                let count = parseInt(badge.textContent) || 0;
                badge.textContent = count + 1;
            }
        }
    </script>
</body>
</html>
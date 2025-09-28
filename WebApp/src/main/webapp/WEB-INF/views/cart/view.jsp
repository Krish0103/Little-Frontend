<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .cart-item {
            transition: all 0.3s ease;
        }
        .cart-item:hover {
            background-color: #f8f9fa;
        }
        .quantity-input {
            width: 80px;
        }
        .cart-summary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
        }
        .btn-checkout {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            padding: 12px 30px;
            font-weight: bold;
        }
        .btn-checkout:hover {
            background: linear-gradient(135deg, #218838 0%, #1ea085 100%);
            transform: translateY(-2px);
        }
        .empty-cart {
            min-height: 400px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
                        <li class="breadcrumb-item active">Shopping Cart</li>
                    </ol>
                </nav>
                <h2 class="display-6 mb-0">
                    <i class="fas fa-shopping-cart text-primary me-2"></i>Your Cart
                </h2>
            </div>
        </div>

        <!-- Success/Error Messages -->
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

        <c:choose>
            <c:when test="${not empty cart && not empty cart.items}">
                <!-- Cart Items -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card shadow-sm">
                            <div class="card-header bg-white">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">
                                        <i class="fas fa-list me-2"></i>Cart Items (${cart.itemCount})
                                    </h5>
                                    <form action="${pageContext.request.contextPath}/cart/clear" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-outline-danger btn-sm" 
                                                onclick="return confirm('Are you sure you want to clear your cart?')">
                                            <i class="fas fa-trash me-1"></i>Clear Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <c:forEach var="item" items="${cart.items}" varStatus="status">
                                    <div class="cart-item p-3 ${!status.last ? 'border-bottom' : ''}">
                                        <div class="row align-items-center">
                                            <div class="col-md-2 text-center mb-3 mb-md-0">
                                                <c:choose>
                                                    <c:when test="${not empty item.imageUrl}">
                                                        <img src="${item.imageUrl}" 
                                                             class="img-fluid rounded" 
                                                             alt="${item.menuItemName}"
                                                             style="width: 80px; height: 80px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="bg-light rounded d-flex align-items-center justify-content-center" 
                                                             style="width: 80px; height: 80px;">
                                                            <i class="fas fa-utensils text-muted"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-md-4 mb-3 mb-md-0">
                                                <h6 class="mb-1">${item.menuItemName}</h6>
                                                <small class="text-muted">
                                                    <i class="fas fa-store me-1"></i>Restaurant Name
                                                </small>
                                                <div class="mt-1">
                                                    <span class="badge bg-primary">${item.category}</span>
                                                </div>
                                            </div>
                                            <div class="col-md-2 text-center mb-3 mb-md-0">
                                                <div class="fw-bold text-success">
                                                    ₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/>
                                                </div>
                                                <small class="text-muted">per item</small>
                                            </div>
                                            <div class="col-md-2 text-center mb-3 mb-md-0">
                                                <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-inline update-quantity-form">
                                                    <input type="hidden" name="menuItemId" value="${item.menuItemId}">
                                                    <div class="input-group input-group-sm">
                                                        <button type="button" class="btn btn-outline-secondary quantity-btn" 
                                                                data-action="decrease">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <input type="number" name="quantity" value="${item.quantity}" 
                                                               min="1" max="10" class="form-control text-center quantity-input">
                                                        <button type="button" class="btn btn-outline-secondary quantity-btn" 
                                                                data-action="increase">
                                                            <i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="col-md-1 text-center mb-3 mb-md-0">
                                                <div class="fw-bold">
                                                    ₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>
                                                </div>
                                            </div>
                                            <div class="col-md-1 text-center">
                                                <form action="${pageContext.request.contextPath}/cart/remove" method="post" class="d-inline">
                                                    <input type="hidden" name="menuItemId" value="${item.menuItemId}">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm" 
                                                            onclick="return confirm('Remove this item from cart?')"
                                                            title="Remove item">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Continue Shopping -->
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/menu" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                            </a>
                        </div>
                    </div>

                    <!-- Cart Summary -->
                    <div class="col-lg-4">
                        <div class="card cart-summary text-white">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-receipt me-2"></i>Order Summary
                                </h5>
                                
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Subtotal (${cart.itemCount} items):</span>
                                    <span>₹<fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0.00"/></span>
                                </div>
                                
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Delivery Fee:</span>
                                    <span>₹40.00</span>
                                </div>
                                
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Taxes & Fees:</span>
                                    <span>₹<fmt:formatNumber value="${cart.totalAmount * 0.05}" pattern="#,##0.00"/></span>
                                </div>
                                
                                <hr class="bg-white">
                                
                                <div class="d-flex justify-content-between mb-3">
                                    <strong>Total Amount:</strong>
                                    <strong>₹<fmt:formatNumber value="${cart.totalAmount + 40 + (cart.totalAmount * 0.05)}" pattern="#,##0.00"/></strong>
                                </div>

                                <!-- Promo Code -->
                                <div class="mb-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Promo code" id="promoCode">
                                        <button class="btn btn-light" type="button" onclick="applyPromoCode()">
                                            Apply
                                        </button>
                                    </div>
                                </div>

                                <!-- Checkout Button -->
                                <div class="d-grid">
                                    <a href="${pageContext.request.contextPath}/cart/checkout" class="btn btn-checkout btn-lg">
                                        <i class="fas fa-credit-card me-2"></i>Proceed to Checkout
                                    </a>
                                </div>

                                <!-- Estimated Delivery -->
                                <div class="text-center mt-3">
                                    <small>
                                        <i class="fas fa-truck me-1"></i>
                                        Estimated delivery: 25-35 minutes
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Methods -->
                        <div class="card mt-3">
                            <div class="card-body">
                                <h6 class="card-title">
                                    <i class="fas fa-credit-card me-2"></i>Accepted Payments
                                </h6>
                                <div class="d-flex gap-2">
                                    <span class="badge bg-primary">Credit Card</span>
                                    <span class="badge bg-success">UPI</span>
                                    <span class="badge bg-warning">Wallet</span>
                                    <span class="badge bg-info">Cash on Delivery</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Empty Cart -->
                <div class="row">
                    <div class="col">
                        <div class="text-center empty-cart d-flex flex-column justify-content-center align-items-center">
                            <i class="fas fa-shopping-cart text-muted mb-4" style="font-size: 5rem;"></i>
                            <h3 class="text-muted mb-3">Your cart is empty</h3>
                            <p class="text-muted mb-4">Looks like you haven't added any items to your cart yet.</p>
                            <a href="/swiggaa/menu" class="btn btn-primary btn-lg">
                                <i class="fas fa-utensils me-2"></i>Start Shopping
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@ include file="../common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Quantity update functionality
        document.querySelectorAll('.quantity-btn').forEach(button => {
            button.addEventListener('click', function() {
                const action = this.dataset.action;
                const form = this.closest('form');
                const quantityInput = form.querySelector('input[name="quantity"]');
                let currentValue = parseInt(quantityInput.value);
                
                if (action === 'increase' && currentValue < 10) {
                    quantityInput.value = currentValue + 1;
                } else if (action === 'decrease' && currentValue > 1) {
                    quantityInput.value = currentValue - 1;
                }
                
                // Auto-submit form after 1 second delay
                clearTimeout(form.updateTimer);
                form.updateTimer = setTimeout(() => {
                    form.submit();
                }, 1000);
            });
        });

        // Quantity input change handler
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', function() {
                const form = this.closest('form');
                clearTimeout(form.updateTimer);
                form.updateTimer = setTimeout(() => {
                    form.submit();
                }, 500);
            });
        });

        // Promo code functionality
        function applyPromoCode() {
            const promoCode = document.getElementById('promoCode').value.trim();
            
            if (!promoCode) {
                alert('Please enter a promo code');
                return;
            }

            // Simulate promo code validation
            const validCodes = ['SAVE10', 'FIRST20', 'WEEKEND15'];
            
            if (validCodes.includes(promoCode.toUpperCase())) {
                alert('Promo code applied successfully! 🎉');
                // In real implementation, this would make an AJAX call to apply the discount
            } else {
                alert('Invalid promo code. Please try again.');
            }
        }

        // Auto-hide alerts after 5 seconds
        document.querySelectorAll('.alert').forEach(alert => {
            setTimeout(() => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }, 5000);
        });
    </script>
</body>
</html>
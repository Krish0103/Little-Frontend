<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            border-left: 4px solid #dee2e6;
        }
        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .order-card.placed { border-left-color: #ffc107; }
        .order-card.confirmed { border-left-color: #17a2b8; }
        .order-card.preparing { border-left-color: #fd7e14; }
        .order-card.out-for-delivery { border-left-color: #6f42c1; }
        .order-card.delivered { border-left-color: #28a745; }
        .order-card.cancelled { border-left-color: #dc3545; }
        
        .status-badge.placed { background: #ffc107; }
        .status-badge.confirmed { background: #17a2b8; }
        .status-badge.preparing { background: #fd7e14; }
        .status-badge.out-for-delivery { background: #6f42c1; }
        .status-badge.delivered { background: #28a745; }
        .status-badge.cancelled { background: #dc3545; }
        
        .filter-btn {
            border: 2px solid transparent;
            transition: all 0.3s;
        }
        .filter-btn.active {
            background-color: #667eea;
            border-color: #667eea;
            color: white;
        }
        .order-timeline {
            position: relative;
        }
        .order-timeline::before {
            content: '';
            position: absolute;
            left: 20px;
            top: 0;
            height: 100%;
            width: 2px;
            background: #dee2e6;
        }
        .timeline-item {
            position: relative;
            padding-left: 50px;
            margin-bottom: 30px;
        }
        .timeline-icon {
            position: absolute;
            left: 8px;
            top: 0;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            background: #dee2e6;
            font-size: 10px;
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
                    <i class="fas fa-receipt text-primary me-2"></i>My Orders
                </h2>
                <p class="text-muted">Track and manage your food orders</p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="/menu" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Order Again
                </a>
            </div>
        </div>

        <!-- Order Filters -->
        <div class="row mb-4">
            <div class="col">
                <div class="d-flex flex-wrap gap-2">
                    <button class="btn filter-btn active" data-status="all">
                        <i class="fas fa-list me-1"></i>All Orders
                    </button>
                    <button class="btn filter-btn" data-status="PLACED">
                        <i class="fas fa-clock me-1"></i>Placed
                    </button>
                    <button class="btn filter-btn" data-status="PREPARING">
                        <i class="fas fa-fire me-1"></i>Preparing
                    </button>
                    <button class="btn filter-btn" data-status="OUT_FOR_DELIVERY">
                        <i class="fas fa-truck me-1"></i>Out for Delivery
                    </button>
                    <button class="btn filter-btn" data-status="DELIVERED">
                        <i class="fas fa-check-circle me-1"></i>Delivered
                    </button>
                    <button class="btn filter-btn" data-status="CANCELLED">
                        <i class="fas fa-times-circle me-1"></i>Cancelled
                    </button>
                </div>
            </div>
        </div>

        <!-- Orders List -->
        <div class="row">
            <div class="col">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="card order-card mb-3 ${order.status.toString().toLowerCase().replace('_', '-')}" 
                                 data-status="${order.status}">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-2 text-center mb-3 mb-md-0">
                                            <div class="fw-bold">Order #${order.id}</div>
                                            <small class="text-muted">
                                                ${fn:substring(order.orderTime, 0, 10)}
                                            </small>
                                            <div class="mt-1">
                                                <span class="badge status-badge ${order.status.toString().toLowerCase().replace('_', '-')}">
                                                    ${order.status.toString().replace('_', ' ')}
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-3 mb-3 mb-md-0">
                                            <h6 class="mb-1">${order.restaurantName}</h6>
                                            <small class="text-muted">
                                                <i class="fas fa-utensils me-1"></i>
                                                ${order.orderItems.size()} item(s)
                                            </small>
                                            <div class="mt-1">
                                                <c:forEach var="item" items="${order.orderItems}" end="2">
                                                    <small class="d-block text-muted">• ${item.itemName}</small>
                                                </c:forEach>
                                                <c:if test="${order.orderItems.size() > 3}">
                                                    <small class="text-muted">... and ${order.orderItems.size() - 3} more</small>
                                                </c:if>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-2 text-center mb-3 mb-md-0">
                                            <div class="fw-bold text-success">
                                                ₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                            </div>
                                            <small class="text-muted">Total Amount</small>
                                        </div>
                                        
                                        <div class="col-md-2 text-center mb-3 mb-md-0">
                                            <c:choose>
                                                <c:when test="${order.status == 'DELIVERED'}">
                                                    <div class="text-success">
                                                        <i class="fas fa-check-circle"></i>
                                                        <small class="d-block">Delivered</small>
                                                    </div>
                                                </c:when>
                                                <c:when test="${order.status == 'CANCELLED'}">
                                                    <div class="text-danger">
                                                        <i class="fas fa-times-circle"></i>
                                                        <small class="d-block">Cancelled</small>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-info">
                                                        <i class="fas fa-clock"></i>
                                                        <small class="d-block">In Progress</small>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <div class="col-md-3 text-md-end">
                                            <div class="btn-group-vertical btn-group-sm w-100" role="group">
                                                <a href="/orders/${order.id}" class="btn btn-outline-primary btn-sm">
                                                    <i class="fas fa-eye me-1"></i>View Details
                                                </a>
                                                
                                                <c:choose>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <button class="btn btn-outline-secondary btn-sm" onclick="reorderItems('${order.id}')">
                                                            <i class="fas fa-redo me-1"></i>Reorder
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${order.status == 'PLACED' || order.status == 'CONFIRMED'}">
                                                        <form action="/orders/${order.id}/cancel" method="post" class="d-inline">
                                                            <button type="submit" class="btn btn-outline-danger btn-sm w-100"
                                                                    onclick="return confirm('Are you sure you want to cancel this order?')">
                                                                <i class="fas fa-times me-1"></i>Cancel
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/orders/track/${order.id}" class="btn btn-outline-info btn-sm">
                                                            <i class="fas fa-map-marker-alt me-1"></i>Track Order
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Delivery Address (collapsed by default) -->
                                    <div class="row mt-2">
                                        <div class="col-12">
                                            <small class="text-muted">
                                                <i class="fas fa-map-marker-alt me-1"></i>
                                                Delivery to: ${order.deliveryAddress}
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty Orders State -->
                        <div class="text-center py-5">
                            <i class="fas fa-receipt text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3 text-muted">No orders found</h3>
                            <p class="text-muted mb-4">You haven't placed any orders yet. Start exploring delicious food!</p>
                            <a href="/menu" class="btn btn-primary btn-lg">
                                <i class="fas fa-utensils me-2"></i>Browse Menu
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Pagination (if needed) -->
        <c:if test="${not empty orders && orders.size() >= 10}">
            <div class="row mt-4">
                <div class="col text-center">
                    <nav aria-label="Orders pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Previous</a>
                            </li>
                            <li class="page-item active">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">2</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">3</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>
    </div>

    <%@ include file="../common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Order filtering
        document.querySelectorAll('.filter-btn').forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
                // Add active class to clicked button
                this.classList.add('active');
                
                const status = this.dataset.status;
                filterOrders(status);
            });
        });

        function filterOrders(status) {
            const orderCards = document.querySelectorAll('.order-card');
            
            orderCards.forEach(card => {
                const cardStatus = card.dataset.status;
                
                if (status === 'all' || cardStatus === status) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Reorder functionality
        function reorderItems(orderId) {
            if (confirm('Do you want to add all items from this order to your cart?')) {
                // This would typically make an AJAX call to add items to cart
                fetch('/orders/' + orderId + '/reorder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                })
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.success) {
                        alert('Items added to cart successfully!');
                        window.location.href = '/cart';
                    } else {
                        alert('Failed to add items to cart. Please try again.');
                    }
                })
                .catch(function(error) {
                    console.error('Error:', error);
                    alert('Failed to add items to cart. Please try again.');
                });
            }
        }

        // Auto-refresh for active orders (every 30 seconds)
        function autoRefresh() {
            var activeOrders = document.querySelectorAll('.order-card[data-status="PLACED"], .order-card[data-status="CONFIRMED"], .order-card[data-status="PREPARING"], .order-card[data-status="OUT_FOR_DELIVERY"]');
            
            if (activeOrders.length > 0) {
                setTimeout(function() {
                    window.location.reload();
                }, 30000); // 30 seconds
            }
        }

        // Initialize auto-refresh
        autoRefresh();

        // Show success/error messages when page loads
        window.addEventListener('DOMContentLoaded', function() {
            var successMessage = '${success}';
            var errorMessage = '${error}';
            
            if (successMessage && successMessage.trim() !== '') {
                showSuccessMessage(successMessage);
            }
            
            if (errorMessage && errorMessage.trim() !== '') {
                showErrorMessage(errorMessage);
            }
        });
        
        function showSuccessMessage(message) {
            var alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-success alert-dismissible fade show position-fixed';
            alertDiv.style.top = '20px';
            alertDiv.style.right = '20px';
            alertDiv.style.zIndex = '9999';
            alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            document.body.appendChild(alertDiv);
            
            setTimeout(function() {
                if (alertDiv && alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }
        
        function showErrorMessage(message) {
            var alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger alert-dismissible fade show position-fixed';
            alertDiv.style.top = '20px';
            alertDiv.style.right = '20px';
            alertDiv.style.zIndex = '9999';
            alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            document.body.appendChild(alertDiv);
            
            setTimeout(function() {
                if (alertDiv && alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }
    </script>
</body>
</html>
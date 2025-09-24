<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-timeline {
            position: relative;
        }
        .order-timeline::before {
            content: '';
            position: absolute;
            left: 30px;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(to bottom, #28a745, #ffc107, #dc3545);
        }
        .timeline-item {
            position: relative;
            padding-left: 70px;
            margin-bottom: 30px;
        }
        .timeline-icon {
            position: absolute;
            left: 15px;
            top: 0;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            border: 3px solid white;
            box-shadow: 0 0 0 3px #dee2e6;
        }
        .timeline-icon.completed { background: #28a745; box-shadow: 0 0 0 3px #28a745; }
        .timeline-icon.current { background: #ffc107; box-shadow: 0 0 0 3px #ffc107; animation: pulse 2s infinite; }
        .timeline-icon.pending { background: #dee2e6; box-shadow: 0 0 0 3px #dee2e6; }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .order-summary-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            position: sticky;
            top: 20px;
        }
        
        .item-card {
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .item-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .status-badge {
            font-size: 0.9rem;
            padding: 8px 16px;
            border-radius: 20px;
        }
        
        .delivery-map {
            height: 300px;
            background: #f8f9fa;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item"><a href="/orders">My Orders</a></li>
                <li class="breadcrumb-item active">Order #${order.id}</li>
            </ol>
        </nav>

        <!-- Order Header -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h2 class="display-6 mb-2">
                    <i class="fas fa-receipt text-primary me-2"></i>
                    Order #${order.id}
                </h2>
                <p class="text-muted mb-2">
                    Placed on <fmt:formatDate value="${order.orderTime}" pattern="EEEE, MMMM dd, yyyy 'at' hh:mm a"/>
                </p>
                <div class="d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${order.status == 'DELIVERED'}">
                            <span class="badge bg-success status-badge">
                                <i class="fas fa-check-circle me-1"></i>Delivered
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'CANCELLED'}">
                            <span class="badge bg-danger status-badge">
                                <i class="fas fa-times-circle me-1"></i>Cancelled
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                            <span class="badge bg-info status-badge">
                                <i class="fas fa-truck me-1"></i>Out for Delivery
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'PREPARING'}">
                            <span class="badge bg-warning status-badge">
                                <i class="fas fa-fire me-1"></i>Preparing
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary status-badge">
                                <i class="fas fa-clock me-1"></i>${order.status}
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="col-md-4 text-md-end">
                <c:if test="${order.status == 'PLACED' || order.status == 'CONFIRMED'}">
                    <form action="/orders/${order.id}/cancel" method="post" class="d-inline">
                        <button type="submit" class="btn btn-outline-danger"
                                onclick="return confirm('Are you sure you want to cancel this order?')">
                            <i class="fas fa-times me-2"></i>Cancel Order
                        </button>
                    </form>
                </c:if>
                <c:if test="${order.status == 'DELIVERED'}">
                    <button class="btn btn-primary" onclick="reorderItems(${order.id})">
                        <i class="fas fa-redo me-2"></i>Reorder
                    </button>
                </c:if>
            </div>
        </div>

        <div class="row">
            <!-- Left Column - Order Details -->
            <div class="col-lg-8">
                
                <!-- Order Tracking Timeline -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">
                            <i class="fas fa-map-marked-alt text-primary me-2"></i>
                            Order Tracking
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="order-timeline">
                            <div class="timeline-item">
                                <div class="timeline-icon completed">
                                    <i class="fas fa-check"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Order Placed</h6>
                                    <p class="text-muted mb-0">
                                        <fmt:formatDate value="${order.orderTime}" pattern="MMM dd, yyyy hh:mm a"/>
                                    </p>
                                    <small class="text-success">✓ Completed</small>
                                </div>
                            </div>
                            
                            <div class="timeline-item">
                                <div class="timeline-icon ${order.status == 'CONFIRMED' || order.status == 'PREPARING' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'completed' : order.status == 'PLACED' ? 'current' : 'pending'}">
                                    <i class="fas fa-utensils"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Restaurant Confirmed</h6>
                                    <p class="text-muted mb-0">
                                        Your order has been confirmed by ${order.restaurantName}
                                    </p>
                                    <c:choose>
                                        <c:when test="${order.status == 'CONFIRMED' || order.status == 'PREPARING' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed</small>
                                        </c:when>
                                        <c:when test="${order.status == 'PLACED'}">
                                            <small class="text-warning">⏳ In Progress</small>
                                        </c:when>
                                        <c:otherwise>
                                            <small class="text-muted">⏸ Pending</small>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <div class="timeline-item">
                                <div class="timeline-icon ${order.status == 'PREPARING' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'completed' : order.status == 'CONFIRMED' ? 'current' : 'pending'}">
                                    <i class="fas fa-fire"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Food is being prepared</h6>
                                    <p class="text-muted mb-0">
                                        Chef is preparing your delicious meal
                                    </p>
                                    <c:choose>
                                        <c:when test="${order.status == 'PREPARING' || order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed</small>
                                        </c:when>
                                        <c:when test="${order.status == 'CONFIRMED'}">
                                            <small class="text-warning">⏳ In Progress</small>
                                        </c:when>
                                        <c:otherwise>
                                            <small class="text-muted">⏸ Pending</small>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <div class="timeline-item">
                                <div class="timeline-icon ${order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED' ? 'completed' : order.status == 'PREPARING' ? 'current' : 'pending'}">
                                    <i class="fas fa-truck"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Out for Delivery</h6>
                                    <p class="text-muted mb-0">
                                        Your order is on the way to your location
                                    </p>
                                    <c:choose>
                                        <c:when test="${order.status == 'OUT_FOR_DELIVERY' || order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed</small>
                                        </c:when>
                                        <c:when test="${order.status == 'PREPARING'}">
                                            <small class="text-warning">⏳ In Progress</small>
                                        </c:when>
                                        <c:otherwise>
                                            <small class="text-muted">⏸ Pending</small>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <div class="timeline-item">
                                <div class="timeline-icon ${order.status == 'DELIVERED' ? 'completed' : order.status == 'OUT_FOR_DELIVERY' ? 'current' : 'pending'}">
                                    <i class="fas fa-home"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Delivered</h6>
                                    <p class="text-muted mb-0">
                                        Order delivered to your doorstep
                                    </p>
                                    <c:choose>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed at 
                                                <fmt:formatDate value="${order.deliveryTime}" pattern="hh:mm a"/>
                                            </small>
                                        </c:when>
                                        <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                            <small class="text-warning">⏳ In Progress</small>
                                        </c:when>
                                        <c:otherwise>
                                            <small class="text-muted">⏸ Pending</small>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">
                            <i class="fas fa-utensils text-primary me-2"></i>
                            Order Items (${order.orderItems.size()})
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                            <div class="item-card p-3 ${!status.last ? 'border-bottom' : ''}">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <h6 class="mb-1">${item.itemName}</h6>
                                        <small class="text-muted">Quantity: ${item.quantity}</small>
                                    </div>
                                    <div class="col-md-3 text-center">
                                        <span class="text-success">₹<fmt:formatNumber value="${item.itemPrice}" pattern="#,##0.00"/></span>
                                        <small class="text-muted d-block">per item</small>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <div class="fw-bold">₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Delivery Information -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">
                            <i class="fas fa-map-marker-alt text-primary me-2"></i>
                            Delivery Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Delivery Address</h6>
                                <p class="text-muted mb-3">${order.deliveryAddress}</p>
                                
                                <h6>Contact Information</h6>
                                <p class="text-muted mb-0">
                                    <i class="fas fa-phone me-1"></i> ${order.phoneNumber}
                                </p>
                            </div>
                            <div class="col-md-6">
                                <div class="delivery-map">
                                    <div class="text-center">
                                        <i class="fas fa-map text-muted mb-2" style="font-size: 2rem;"></i>
                                        <p class="text-muted">Delivery Map</p>
                                        <small class="text-muted">Interactive map coming soon</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty order.specialInstructions}">
                            <hr>
                            <h6>Special Instructions</h6>
                            <p class="text-muted mb-0">${order.specialInstructions}</p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Right Column - Order Summary -->
            <div class="col-lg-4">
                <div class="card order-summary-card text-white mb-4">
                    <div class="card-body">
                        <h5 class="card-title mb-3">
                            <i class="fas fa-receipt me-2"></i>Order Summary
                        </h5>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1">
                                <span>Restaurant:</span>
                                <span class="fw-bold">${order.restaurantName}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Payment Method:</span>
                                <span>${order.paymentMethod}</span>
                            </div>
                        </div>

                        <hr class="bg-white opacity-50">

                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <span>₹<fmt:formatNumber value="${order.totalAmount - 40 - (order.totalAmount * 0.05)}" pattern="#,##0.00"/></span>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span>Delivery Fee:</span>
                            <span>₹40.00</span>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-3">
                            <span>Taxes & Fees:</span>
                            <span>₹<fmt:formatNumber value="${order.totalAmount * 0.05}" pattern="#,##0.00"/></span>
                        </div>

                        <hr class="bg-white">

                        <div class="d-flex justify-content-between mb-3">
                            <strong>Total Paid:</strong>
                            <strong class="fs-5">₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></strong>
                        </div>

                        <c:if test="${order.status == 'DELIVERED'}">
                            <div class="text-center">
                                <small class="opacity-75">
                                    <i class="fas fa-check-circle me-1"></i>
                                    Payment completed successfully
                                </small>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Need Help Card -->
                <div class="card">
                    <div class="card-body text-center">
                        <h6 class="card-title">Need Help?</h6>
                        <p class="card-text small text-muted">Having issues with your order? We're here to help!</p>
                        <div class="d-grid gap-2">
                            <a href="tel:+919876543210" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-phone me-1"></i>Call Support
                            </a>
                            <button class="btn btn-outline-secondary btn-sm" onclick="openChat()">
                                <i class="fas fa-comments me-1"></i>Live Chat
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Reorder functionality
        function reorderItems(orderId) {
            if (confirm('Add all items from this order to your cart?')) {
                fetch(`/orders/${orderId}/reorder`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Items added to cart successfully! 🛒');
                        window.location.href = '/cart';
                    } else {
                        alert('Failed to add items to cart.');
                    }
                })
                .catch(() => alert('Something went wrong. Please try again.'));
            }
        }

        // Live chat functionality
        function openChat() {
            alert('Live chat feature coming soon! Please call our support number for immediate assistance.');
        }

        // Auto-refresh for active orders
        <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
            setInterval(() => {
                fetch(`/orders/${order.id}/status`)
                    .then(response => response.json())
                    .then(data => {
                        if (data.status !== '${order.status}') {
                            location.reload();
                        }
                    })
                    .catch(() => console.log('Status check failed'));
            }, 30000); // Check every 30 seconds
        </c:if>
    </script>
</body>
</html>
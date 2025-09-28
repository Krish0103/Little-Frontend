<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .quick-action {
            border: 2px dashed #dee2e6;
            transition: all 0.3s;
        }
        .quick-action:hover {
            border-color: #667eea;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <%@ include file="common/navbar.jsp" %>

    <div class="container mt-4">
        <!-- Welcome Header -->
        <div class="row mb-4">
            <div class="col">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h1 class="display-6 mb-1">Welcome back, ${not empty loggedInUser ? loggedInUser : 'User'}!</h1>
                        <p class="text-muted mb-0">
                            <i class="fas fa-clock me-2"></i>Last login: Today at 2:30 PM
                        </p>
                    </div>
                    <div>
                        <span class="badge bg-primary fs-6">
                            <i class="fas fa-user me-2"></i>${not empty userRole ? userRole : 'USER'}
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="row mb-4">
            <c:choose>
                <c:when test="${userRole == 'ROLE_USER' or empty userRole}">>
                    <!-- Customer Stats -->
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-shopping-bag mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">12</h4>
                                <p class="mb-0">Total Orders</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-heart mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">8</h4>
                                <p class="mb-0">Favorites</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-dollar-sign mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">₹2,450</h4>
                                <p class="mb-0">Total Spent</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-star mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">4.8</h4>
                                <p class="mb-0">Avg Rating</p>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Restaurant Owner Stats -->
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-receipt mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">45</h4>
                                <p class="mb-0">Orders Today</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-utensils mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">24</h4>
                                <p class="mb-0">Menu Items</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-rupee-sign mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">₹15,300</h4>
                                <p class="mb-0">Today's Revenue</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card border-0">
                            <div class="card-body text-center">
                                <i class="fas fa-star mb-2" style="font-size: 2.5rem;"></i>
                                <h4 class="mb-1">4.6</h4>
                                <p class="mb-0">Restaurant Rating</p>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col">
                <h4 class="mb-3">Quick Actions</h4>
                <div class="row">
                    <c:choose>
                        <c:when test="${userRole == 'ROLE_USER'}">
                            <!-- Customer Actions -->
                            <div class="col-md-3 mb-3">
                                <a href="${pageContext.request.contextPath}/menu" class="text-decoration-none">
                                    <div class="card quick-action h-100">
                                        <div class="card-body text-center">
                                            <i class="fas fa-utensils text-primary mb-2" style="font-size: 2rem;"></i>
                                            <h6>Browse Menu</h6>
                                            <p class="text-muted small mb-0">Explore delicious food options</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3 mb-3">
                                <a href="${pageContext.request.contextPath}/orders" class="text-decoration-none">
                                    <div class="card quick-action h-100">
                                        <div class="card-body text-center">
                                            <i class="fas fa-history text-success mb-2" style="font-size: 2rem;"></i>
                                            <h6>Order History</h6>
                                            <p class="text-muted small mb-0">View your past orders</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3 mb-3">
                                <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">
                                    <div class="card quick-action h-100">
                                        <div class="card-body text-center">
                                            <i class="fas fa-shopping-cart text-warning mb-2" style="font-size: 2rem;"></i>
                                            <h6>View Cart</h6>
                                            <p class="text-muted small mb-0">Check your cart items</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-3 mb-3">
                                <a href="/menu/search" class="text-decoration-none">
                                    <div class="card quick-action h-100">
                                        <div class="card-body text-center">
                                            <i class="fas fa-search text-info mb-2" style="font-size: 2rem;"></i>
                                            <h6>Search Food</h6>
                                            <p class="text-muted small mb-0">Find your favorite dishes</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Restaurant Owner Actions -->
                            <div class="col-md-3 mb-3">
                                <div class="card quick-action h-100">
                                    <div class="card-body text-center">
                                        <i class="fas fa-plus-circle text-primary mb-2" style="font-size: 2rem;"></i>
                                        <h6>Add Menu Item</h6>
                                        <p class="text-muted small mb-0">Add new dishes to menu</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="card quick-action h-100">
                                    <div class="card-body text-center">
                                        <i class="fas fa-list text-success mb-2" style="font-size: 2rem;"></i>
                                        <h6>Manage Orders</h6>
                                        <p class="text-muted small mb-0">View and update orders</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="card quick-action h-100">
                                    <div class="card-body text-center">
                                        <i class="fas fa-chart-bar text-warning mb-2" style="font-size: 2rem;"></i>
                                        <h6>Analytics</h6>
                                        <p class="text-muted small mb-0">View sales reports</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="card quick-action h-100">
                                    <div class="card-body text-center">
                                        <i class="fas fa-cog text-info mb-2" style="font-size: 2rem;"></i>
                                        <h6>Settings</h6>
                                        <p class="text-muted small mb-0">Restaurant settings</p>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="row">
            <div class="col-md-8">
                <div class="card dashboard-card">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">
                            <i class="fas fa-clock me-2"></i>Recent Activity
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${userRole == 'ROLE_USER'}">
                                <!-- Customer Recent Orders -->
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Order #12345 - Pizza Margherita</h6>
                                            <p class="text-muted mb-0 small">Delivered - 2 hours ago</p>
                                        </div>
                                        <span class="badge bg-success">₹450</span>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Order #12344 - Chicken Biryani</h6>
                                            <p class="text-muted mb-0 small">Delivered - 1 day ago</p>
                                        </div>
                                        <span class="badge bg-success">₹320</span>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Order #12343 - Burger Combo</h6>
                                            <p class="text-muted mb-0 small">Delivered - 3 days ago</p>
                                        </div>
                                        <span class="badge bg-success">₹280</span>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Restaurant Recent Orders -->
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Order #12348 - Table 5</h6>
                                            <p class="text-muted mb-0 small">Preparing - 15 min ago</p>
                                        </div>
                                        <span class="badge bg-warning">₹850</span>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Order #12347 - Online Order</h6>
                                            <p class="text-muted mb-0 small">Out for Delivery - 30 min ago</p>
                                        </div>
                                        <span class="badge bg-info">₹420</span>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-1">Order #12346 - Takeaway</h6>
                                            <p class="text-muted mb-0 small">Completed - 1 hour ago</p>
                                        </div>
                                        <span class="badge bg-success">₹650</span>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="text-center mt-3">
                            <a href="/orders" class="btn btn-outline-primary btn-sm">
                                View All Orders <i class="fas fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card dashboard-card">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">
                            <i class="fas fa-bell me-2"></i>Notifications
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <div class="list-group-item border-0 px-0">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-gift text-success me-3 mt-1"></i>
                                    <div>
                                        <h6 class="mb-1">Special Offer!</h6>
                                        <p class="text-muted mb-0 small">Get 20% off on orders above ₹500</p>
                                    </div>
                                </div>
                            </div>
                            <div class="list-group-item border-0 px-0">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-star text-warning me-3 mt-1"></i>
                                    <div>
                                        <h6 class="mb-1">Rate Your Order</h6>
                                        <p class="text-muted mb-0 small">How was your Pizza Margherita?</p>
                                    </div>
                                </div>
                            </div>
                            <div class="list-group-item border-0 px-0">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-truck text-primary me-3 mt-1"></i>
                                    <div>
                                        <h6 class="mb-1">Delivery Update</h6>
                                        <p class="text-muted mb-0 small">Your order is on the way!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="common/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
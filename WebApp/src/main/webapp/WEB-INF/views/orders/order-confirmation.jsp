<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .confirmation-container {
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .confirmation-card {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(40, 167, 69, 0.3);
            max-width: 600px;
            margin: auto;
        }
        .confirmation-icon {
            width: 120px;
            height: 120px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
        }
        .confirmation-icon i {
            font-size: 4rem;
            color: white;
        }
        .order-summary {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin: 2rem 0;
        }
        .navigation-buttons .btn {
            min-width: 200px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .btn-orders {
            background: white;
            color: #28a745;
            border: 2px solid white;
        }
        .btn-orders:hover {
            background: transparent;
            color: white;
            transform: translateY(-2px);
        }
        .btn-menu {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        .btn-menu:hover {
            background: white;
            color: #28a745;
            transform: translateY(-2px);
        }
        .pulse {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <%@ include file="../common/navbar.jsp" %>

    <div class="confirmation-container">
        <div class="container">
            <div class="confirmation-card">
                <div class="card-body text-center p-5">
                    
                    <!-- Success Icon -->
                    <div class="confirmation-icon pulse">
                        <i class="fas fa-check-circle"></i>
                    </div>

                    <!-- Success Message -->
                    <h1 class="display-4 fw-bold mb-3">Order Placed Successfully!</h1>
                    <p class="lead mb-4">
                        Thank you for your order! Your delicious food is being prepared and will be delivered soon.
                    </p>

                    <!-- Order Summary -->
                    <c:if test="${not empty order}">
                        <div class="order-summary">
                            <div class="row">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <h5><i class="fas fa-receipt me-2"></i>Order Details</h5>
                                    <p class="mb-1"><strong>Order ID:</strong> #${order.id}</p>
                                    <p class="mb-1"><strong>Restaurant:</strong> ${order.restaurantName}</p>
                                    <p class="mb-0"><strong>Total Amount:</strong> ₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></p>
                                </div>
                                <div class="col-md-6">
                                    <h5><i class="fas fa-truck me-2"></i>Delivery Info</h5>
                                    <p class="mb-1"><strong>Estimated Time:</strong> 25-35 minutes</p>
                                    <p class="mb-1"><strong>Payment:</strong> ${order.paymentMethod}</p>
                                    <p class="mb-0"><strong>Status:</strong> <span class="badge bg-light text-dark">Order Placed</span></p>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Navigation Buttons -->
                    <div class="navigation-buttons">
                        <div class="row g-3 justify-content-center">
                            <div class="col-md-6 col-lg-5">
                                <a href="${pageContext.request.contextPath}/orders" class="btn btn-orders btn-lg w-100">
                                    <i class="fas fa-list-alt me-2"></i>View Your Orders
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-5">
                                <a href="${pageContext.request.contextPath}/menu" class="btn btn-menu btn-lg w-100">
                                    <i class="fas fa-utensils me-2"></i>Browse Menu
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Message -->
                    <div class="mt-4">
                        <p class="mb-0">
                            <i class="fas fa-info-circle me-2"></i>
                            You can track your order status in the <strong>Orders</strong> section.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Additional Information Cards -->
            <div class="row mt-5">
                <div class="col-md-4 mb-3">
                    <div class="card text-center border-0 shadow-sm">
                        <div class="card-body">
                            <i class="fas fa-clock text-primary mb-2" style="font-size: 2rem;"></i>
                            <h5>Fast Delivery</h5>
                            <p class="text-muted small mb-0">Your order will be delivered within the estimated time</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card text-center border-0 shadow-sm">
                        <div class="card-body">
                            <i class="fas fa-mobile-alt text-success mb-2" style="font-size: 2rem;"></i>
                            <h5>Real-time Updates</h5>
                            <p class="text-muted small mb-0">Get notifications about your order status</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card text-center border-0 shadow-sm">
                        <div class="card-body">
                            <i class="fas fa-headset text-info mb-2" style="font-size: 2rem;"></i>
                            <h5>Support</h5>
                            <p class="text-muted small mb-0">Need help? Our support team is here for you</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="../common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Auto-redirect after 30 seconds (optional) -->
    <script>
        // Optional: Auto-redirect to orders page after 30 seconds
        // setTimeout(function() {
        //     window.location.href = '${pageContext.request.contextPath}/orders';
        // }, 30000);
        
        // Add a subtle animation to the buttons
        document.addEventListener('DOMContentLoaded', function() {
            const buttons = document.querySelectorAll('.navigation-buttons .btn');
            buttons.forEach((button, index) => {
                setTimeout(() => {
                    button.style.opacity = '0';
                    button.style.transform = 'translateY(20px)';
                    button.style.transition = 'all 0.5s ease';
                    
                    setTimeout(() => {
                        button.style.opacity = '1';
                        button.style.transform = 'translateY(0)';
                    }, 100);
                }, index * 200 + 1000); // Delay based on button index
            });
        });
    </script>
</body>
</html>
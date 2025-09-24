<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .checkout-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .payment-method {
            border: 2px solid #dee2e6;
            border-radius: 10px;
            padding: 1rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payment-method:hover {
            border-color: #667eea;
            background-color: #f8f9fa;
        }
        .payment-method.selected {
            border-color: #667eea;
            background-color: #e7f3ff;
        }
        .order-summary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            position: sticky;
            top: 20px;
        }
        .place-order-btn {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: bold;
        }
        .place-order-btn:hover {
            background: linear-gradient(135deg, #218838 0%, #1ea085 100%);
            transform: translateY(-2px);
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
                <li class="breadcrumb-item active">Checkout</li>
            </ol>
        </nav>

        <h2 class="display-6 mb-4">
            <i class="fas fa-credit-card text-primary me-2"></i>Checkout
        </h2>

        <form action="${pageContext.request.contextPath}/orders/place" method="post" id="checkoutForm">
            <div class="row">
                <!-- Left Column - Checkout Form -->
                <div class="col-lg-8">
                    
                    <!-- Delivery Information -->
                    <div class="checkout-section">
                        <h4 class="mb-3">
                            <i class="fas fa-map-marker-alt text-primary me-2"></i>
                            Delivery Information
                        </h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fullName" class="form-label">Full Name *</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                       value="${sessionScope.user}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phoneNumber" class="form-label">Phone Number *</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" 
                                       value="${userPhone != null ? userPhone : ''}" 
                                       placeholder="+91 9876543210" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="deliveryAddress" class="form-label">Delivery Address *</label>
                            <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" 
                                    rows="3" placeholder="Enter your complete delivery address" required>${userAddress != null ? userAddress : ''}</textarea>
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>Using your registered address. You can modify it if needed.
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="city" class="form-label">City *</label>
                                <input type="text" class="form-control" id="city" name="city" 
                                       value="Bangalore" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="state" class="form-label">State *</label>
                                <input type="text" class="form-control" id="state" name="state" 
                                       value="Karnataka" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="pincode" class="form-label">Pincode *</label>
                                <input type="text" class="form-control" id="pincode" name="pincode" 
                                       placeholder="560001" pattern="[0-9]{6}" required>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div class="checkout-section">
                        <h4 class="mb-3">
                            <i class="fas fa-credit-card text-primary me-2"></i>
                            Payment Method
                        </h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="payment-method" onclick="selectPaymentMethod('credit-card')">
                                    <input type="radio" name="paymentMethod" value="Credit Card" 
                                           id="credit-card" class="form-check-input me-2">
                                    <i class="fas fa-credit-card text-primary me-2"></i>
                                    <strong>Credit/Debit Card</strong>
                                    <p class="mb-0 text-muted small mt-1">Visa, Mastercard, RuPay accepted</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="payment-method" onclick="selectPaymentMethod('upi')">
                                    <input type="radio" name="paymentMethod" value="UPI" 
                                           id="upi" class="form-check-input me-2">
                                    <i class="fas fa-mobile-alt text-success me-2"></i>
                                    <strong>UPI Payment</strong>
                                    <p class="mb-0 text-muted small mt-1">GooglePay, PhonePe, Paytm</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="payment-method" onclick="selectPaymentMethod('wallet')">
                                    <input type="radio" name="paymentMethod" value="Digital Wallet" 
                                           id="wallet" class="form-check-input me-2">
                                    <i class="fas fa-wallet text-warning me-2"></i>
                                    <strong>Digital Wallet</strong>
                                    <p class="mb-0 text-muted small mt-1">Paytm, Amazon Pay, etc.</p>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="payment-method" onclick="selectPaymentMethod('cod')">
                                    <input type="radio" name="paymentMethod" value="Cash on Delivery" 
                                           id="cod" class="form-check-input me-2" checked>
                                    <i class="fas fa-money-bill-wave text-info me-2"></i>
                                    <strong>Cash on Delivery</strong>
                                    <p class="mb-0 text-muted small mt-1">Pay when order arrives</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Special Instructions -->
                    <div class="checkout-section">
                        <h4 class="mb-3">
                            <i class="fas fa-sticky-note text-primary me-2"></i>
                            Special Instructions
                        </h4>
                        
                        <div class="mb-3">
                            <textarea class="form-control" id="specialInstructions" name="specialInstructions" 
                                    rows="3" placeholder="Any special instructions for the restaurant or delivery (optional)"></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="contactless">
                                    <label class="form-check-label" for="contactless">
                                        Contactless Delivery
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="callBeforeDelivery">
                                    <label class="form-check-label" for="callBeforeDelivery">
                                        Call before delivery
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Confirmation -->
                    <div class="checkout-section">
                        <h4 class="mb-3">
                            <i class="fas fa-check-circle text-primary me-2"></i>
                            Confirm Your Order
                        </h4>
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Please review your order details, delivery address, and payment method before placing your order.
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                    <label class="form-check-label" for="agreeTerms">
                                        I agree to the <a href="#" class="text-primary">Terms of Service</a> and 
                                        <a href="#" class="text-primary">Privacy Policy</a>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="confirmOrder" required>
                                    <label class="form-check-label" for="confirmOrder">
                                        I confirm that all details are correct
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Order Summary -->
                <div class="col-lg-4">
                    <div class="card order-summary">
                        <div class="card-body">
                            <h5 class="card-title mb-3">
                                <i class="fas fa-receipt me-2"></i>Order Summary
                            </h5>

                            <!-- Order Items -->
                            <div class="mb-3">
                                <c:forEach var="item" items="${cart.items}">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <div>
                                            <small class="fw-bold">${item.menuItemName}</small>
                                            <small class="text-light d-block">Qty: ${item.quantity}</small>
                                        </div>
                                        <small>₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></small>
                                    </div>
                                </c:forEach>
                            </div>

                            <hr class="bg-white opacity-50">

                            <!-- Price Breakdown -->
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

                            <!-- Estimated Delivery -->
                            <div class="text-center mb-3">
                                <small>
                                    <i class="fas fa-clock me-1"></i>
                                    Estimated delivery: 25-35 minutes
                                </small>
                            </div>

                            <!-- Place Order Button -->
                            <div class="d-grid">
                                <button type="submit" class="btn place-order-btn btn-lg">
                                    <i class="fas fa-shopping-bag me-2"></i>
                                    Place Order
                                </button>
                            </div>

                            <!-- Security Note -->
                            <div class="text-center mt-3">
                                <small>
                                    <i class="fas fa-shield-alt me-1"></i>
                                    Your payment information is secure
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <%@ include file="../common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Payment method selection
        function selectPaymentMethod(method) {
            // Remove selected class from all payment methods
            document.querySelectorAll('.payment-method').forEach(element => {
                element.classList.remove('selected');
            });
            
            // Add selected class to clicked method
            document.getElementById(method).closest('.payment-method').classList.add('selected');
            
            // Check the radio button
            document.getElementById(method).checked = true;
        }

        // Initialize with COD selected
        document.addEventListener('DOMContentLoaded', function() {
            selectPaymentMethod('cod');
        });

        // Form validation
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const requiredFields = ['fullName', 'phoneNumber', 'deliveryAddress', 'city', 'state', 'pincode'];
            let isValid = true;
            
            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            // Validate phone number
            const phoneNumber = document.getElementById('phoneNumber').value;
            const phoneRegex = /^[+]?[0-9]{10,14}$/;
            if (!phoneRegex.test(phoneNumber.replace(/\s/g, ''))) {
                document.getElementById('phoneNumber').classList.add('is-invalid');
                isValid = false;
            }
            
            // Validate pincode
            const pincode = document.getElementById('pincode').value;
            const pincodeRegex = /^[0-9]{6}$/;
            if (!pincodeRegex.test(pincode)) {
                document.getElementById('pincode').classList.add('is-invalid');
                isValid = false;
            }
            
            // Check payment method
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            if (!paymentMethod) {
                alert('Please select a payment method');
                isValid = false;
            }
            
            // Check required checkboxes
            const agreeTerms = document.getElementById('agreeTerms');
            const confirmOrder = document.getElementById('confirmOrder');
            
            if (!agreeTerms.checked) {
                alert('Please agree to the Terms of Service and Privacy Policy');
                isValid = false;
            }
            
            if (!confirmOrder.checked) {
                alert('Please confirm that all details are correct');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill all required fields correctly and accept the terms');
                return false;
            }
            
            // Show loading state
            const submitBtn = e.target.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing Order...';
            submitBtn.disabled = true;
        });

        // Auto-format phone number
        document.getElementById('phoneNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length <= 10) {
                e.target.value = value;
            } else {
                e.target.value = value.substring(0, 10);
            }
        });

        // Auto-format pincode
        document.getElementById('pincode').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length <= 6) {
                e.target.value = value;
            } else {
                e.target.value = value.substring(0, 6);
            }
        });
    </script>
</body>
</html>
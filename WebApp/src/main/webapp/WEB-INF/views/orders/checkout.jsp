<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp"/>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-credit-card"></i> Checkout</h5>
            </div>
            <div class="card-body">
                <form:form modelAttribute="order" action="/swiggaa/orders/place" method="post">
                    <h6>Delivery Information</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="customerName" class="form-label">Full Name</label>
                            <form:input path="customerName" class="form-control" value="${user.username}" required="true"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="customerEmail" class="form-label">Email</label>
                            <form:input path="customerEmail" type="email" class="form-control" value="${user.email}" required="true"/>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="customerPhone" class="form-label">Phone Number</label>
                            <form:input path="customerPhone" class="form-control" value="${user.phone}" required="true"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="paymentMethod" class="form-label">Payment Method</label>
                            <form:select path="paymentMethod" class="form-select" required="true">
                                <option value="">Select Payment Method</option>
                                <option value="COD">Cash on Delivery</option>
                                <option value="CARD">Credit/Debit Card</option>
                                <option value="UPI">UPI</option>
                                <option value="WALLET">Digital Wallet</option>
                            </form:select>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="deliveryAddress" class="form-label">Delivery Address</label>
                        <form:textarea path="deliveryAddress" class="form-control" rows="3" 
                                      placeholder="${user.address}" required="true"/>
                    </div>
                    
                    <div class="mb-3">
                        <label for="specialInstructions" class="form-label">Special Instructions (Optional)</label>
                        <form:textarea path="specialInstructions" class="form-control" rows="2" 
                                      placeholder="Any special requests for your order..."/>
                    </div>
                    
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-check"></i> Place Order
                    </button>
                    <a href="/swiggaa/cart" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Cart
                    </a>
                </form:form>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h6><i class="fas fa-receipt"></i> Order Summary</h6>
            </div>
            <div class="card-body">
                <c:forEach var="item" items="${cart.items}">
                    <div class="d-flex justify-content-between mb-2">
                        <div>
                            <span class="fw-medium">${item.menuItemName}</span>
                            <small class="text-muted d-block">Qty: ${item.quantity}</small>
                        </div>
                        <span>₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></span>
                    </div>
                </c:forEach>
                
                <hr>
                
                <div class="d-flex justify-content-between mb-2">
                    <span>Subtotal:</span>
                    <span>₹<fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0.00"/></span>
                </div>
                
                <div class="d-flex justify-content-between mb-2">
                    <span>Delivery Fee:</span>
                    <span>₹40.00</span>
                </div>
                
                <div class="d-flex justify-content-between mb-2">
                    <span>Taxes:</span>
                    <span>₹<fmt:formatNumber value="${cart.totalAmount * 0.05}" pattern="#,##0.00"/></span>
                </div>
                
                <hr>
                
                <div class="d-flex justify-content-between fw-bold h5">
                    <span>Total:</span>
                    <span>₹<fmt:formatNumber value="${cart.totalAmount + 40 + (cart.totalAmount * 0.05)}" pattern="#,##0.00"/></span>
                </div>
                
                <div class="alert alert-info mt-3">
                    <small>
                        <i class="fas fa-info-circle"></i>
                        Your order will be delivered within 30-45 minutes.
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
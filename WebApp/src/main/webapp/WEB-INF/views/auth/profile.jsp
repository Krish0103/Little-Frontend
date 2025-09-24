<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp"/>

<div class="row">
    <div class="col-md-8 mx-auto">
        <div class="card">
            <div class="card-header">
                <h4 class="mb-0"><i class="fas fa-user"></i> My Profile</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h6><strong>Username:</strong></h6>
                        <p>${user.username}</p>
                    </div>
                    <div class="col-md-6">
                        <h6><strong>Email:</strong></h6>
                        <p>${user.email}</p>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <h6><strong>Phone:</strong></h6>
                        <p>${user.phone}</p>
                    </div>
                    <div class="col-md-6">
                        <h6><strong>Role:</strong></h6>
                        <p><span class="badge bg-primary">${user.role}</span></p>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12">
                        <h6><strong>Address:</strong></h6>
                        <p>${user.address}</p>
                    </div>
                </div>
                
                <hr>
                <div class="d-flex gap-2">
                    <a href="/swiggaa/orders" class="btn btn-primary">
                        <i class="fas fa-shopping-bag"></i> My Orders
                    </a>
                    <a href="/swiggaa/menu" class="btn btn-outline-primary">
                        <i class="fas fa-utensils"></i> Browse Menu
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
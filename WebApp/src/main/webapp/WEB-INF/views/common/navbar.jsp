<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-utensils me-2"></i>Swiggaa
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Search Bar (for logged in users) -->
            <c:if test="${not empty sessionScope.user}">
                <form class="d-flex mx-auto" style="width: 300px;" action="${pageContext.request.contextPath}/menu/search" method="get">
                    <div class="input-group">
                        <input class="form-control" type="search" name="query" placeholder="Search for food..." aria-label="Search">
                        <button class="btn btn-outline-light" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </c:if>

            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home me-1"></i>Home
                    </a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <!-- Logged in user menu -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/menu">
                                <i class="fas fa-utensils me-1"></i>Menu
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="${pageContext.request.contextPath}/cart">
                                <i class="fas fa-shopping-cart me-1"></i>Cart
                                <c:if test="${not empty sessionScope.cart && sessionScope.cart.itemCount > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning">
                                        ${sessionScope.cart.itemCount}
                                    </span>
                                </c:if>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/orders">
                                <i class="fas fa-receipt me-1"></i>Orders
                            </a>
                        </li>
                        
                        <!-- User dropdown -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-1"></i>${sessionScope.user}
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="fas fa-user-edit me-2"></i>Profile
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <c:if test="${sessionScope.role == 'ROLE_ADMIN'}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                                            <i class="fas fa-cogs me-2"></i>Admin Panel
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Guest user menu -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/register">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
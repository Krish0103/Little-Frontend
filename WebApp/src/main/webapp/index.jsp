<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swiggaa - Food Delivery Made Easy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
        }
        .feature-card {
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-utensils me-2"></i>Swiggaa
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty loggedInUser}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/menu">Menu</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart"></i> Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/orders">Orders</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <span class="nav-link">Welcome, ${loggedInUser}!</span>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/auth/register">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Delicious Food Delivered Fast</h1>
                    <p class="lead mb-4">Order your favorite meals from the best restaurants in town. Fresh, fast, and delivered right to your door!</p>
                    <c:choose>
                        <c:when test="${not empty loggedInUser}">
                            <a href="${pageContext.request.contextPath}/menu" class="btn btn-light btn-lg me-3">
                                <i class="fas fa-utensils me-2"></i>Browse Menu
                            </a>
                            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-history me-2"></i>My Orders
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-light btn-lg me-3">
                                <i class="fas fa-user-plus me-2"></i>Get Started
                            </a>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-lg-6 text-center">
                    <i class="fas fa-pizza-slice" style="font-size: 12rem; opacity: 0.8;"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col">
                    <h2 class="display-5 fw-bold">Why Choose Swiggaa?</h2>
                    <p class="lead text-muted">Experience the best food delivery service in town</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100 border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-clock text-primary mb-3" style="font-size: 3rem;"></i>
                            <h5 class="card-title">Fast Delivery</h5>
                            <p class="card-text">Get your food delivered in 30 minutes or less with our efficient delivery network.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100 border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-star text-warning mb-3" style="font-size: 3rem;"></i>
                            <h5 class="card-title">Quality Food</h5>
                            <p class="card-text">Fresh ingredients and top-rated restaurants ensure the best dining experience.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100 border-0 shadow-sm">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-mobile-alt text-success mb-3" style="font-size: 3rem;"></i>
                            <h5 class="card-title">Easy Ordering</h5>
                            <p class="card-text">Simple and intuitive interface makes ordering your favorite food a breeze.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col">
                    <h2 class="display-5 fw-bold">Popular Categories</h2>
                    <p class="lead text-muted">Explore our most loved food categories</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4">
                    <a href="${pageContext.request.contextPath}/menu/category/Pizza" class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm">
                            <div class="card-body">
                                <i class="fas fa-pizza-slice text-danger mb-2" style="font-size: 2.5rem;"></i>
                                <h6 class="card-title">Pizza</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <a href="${pageContext.request.contextPath}/menu/category/Burger" class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm">
                            <div class="card-body">
                                <i class="fas fa-hamburger text-warning mb-2" style="font-size: 2.5rem;"></i>
                                <h6 class="card-title">Burgers</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <a href="${pageContext.request.contextPath}/menu/category/Indian" class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm">
                            <div class="card-body">
                                <i class="fas fa-pepper-hot text-danger mb-2" style="font-size: 2.5rem;"></i>
                                <h6 class="card-title">Indian</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <a href="${pageContext.request.contextPath}/menu/category/Dessert" class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm">
                            <div class="card-body">
                                <i class="fas fa-ice-cream text-info mb-2" style="font-size: 2.5rem;"></i>
                                <h6 class="card-title">Desserts</h6>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-utensils me-2"></i>Swiggaa</h5>
                    <p>Your favorite food delivery platform. Order now and enjoy delicious meals at home!</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2025 Swiggaa. All rights reserved.</p>
                    <div>
                        <a href="#" class="text-light me-3"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-light"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
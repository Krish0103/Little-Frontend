<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .error-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .error-card {
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="error-container d-flex align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card error-card border-0">
                    <div class="card-body p-5 text-center">
                        <div class="mb-4">
                            <i class="fas fa-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                        </div>
                        
                        <h2 class="text-primary mb-3">Oops! Something went wrong</h2>
                        <p class="text-muted mb-4">We're sorry, but there was an error processing your request.</p>
                        
                        <c:if test="${not empty status}">
                            <div class="alert alert-info">
                                <strong>Error Code:</strong> ${status}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty message}">
                            <div class="alert alert-warning">
                                <strong>Message:</strong> ${message}
                            </div>
                        </c:if>
                        
                        <div class="d-grid gap-2 mt-4">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="fas fa-home me-2"></i>Go Back to Home
                            </a>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-secondary">
                                <i class="fas fa-sign-in-alt me-2"></i>Try Login Again
                            </a>
                        </div>
                        
                        <div class="mt-4">
                            <small class="text-muted">
                                If this problem persists, please contact our support team.
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
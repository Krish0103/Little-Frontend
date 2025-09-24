<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Swiggaa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .register-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .register-card {
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
            transform: translateY(-2px);
        }
        .password-strength {
            height: 5px;
            border-radius: 3px;
            transition: all 0.3s;
        }
    </style>
</head>
<body class="register-container d-flex align-items-center py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card register-card border-0">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                                <h2 class="text-primary mb-2">
                                    <i class="fas fa-utensils me-2"></i>Swiggaa
                                </h2>
                            </a>
                            <p class="text-muted">Join Swiggaa and start ordering delicious food!</p>
                        </div>

                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/auth/register" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user me-2"></i>Username
                                </label>
                                <input type="text" class="form-control" id="username" name="username" 
                                       placeholder="Choose a username" value="${user.username}" 
                                       minlength="3" maxlength="50" required>
                                <div class="invalid-feedback">
                                    Username must be between 3 and 50 characters.
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>Choose a unique username (3-50 characters)
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope me-2"></i>Email Address
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Enter your email address" value="${user.email}" required>
                                <div class="invalid-feedback">
                                    Please provide a valid email address.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone me-2"></i>Phone Number
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       placeholder="Enter your phone number" value="${user.phone}" required>
                                <div class="invalid-feedback">
                                    Please provide a valid phone number.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Address
                                </label>
                                <textarea class="form-control" id="address" name="address" rows="2" 
                                          placeholder="Enter your address (optional)">${user.address}</textarea>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>This will be used for food delivery
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Password
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Create a strong password" minlength="6" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback">
                                    Password must be at least 6 characters long.
                                </div>
                                <div class="mt-2">
                                    <div class="password-strength bg-light" id="passwordStrength"></div>
                                    <small class="form-text text-muted" id="passwordHelp">
                                        <i class="fas fa-shield-alt me-1"></i>Password strength: <span id="strengthText">Enter password</span>
                                    </small>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Confirm Password
                                </label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       placeholder="Confirm your password" required>
                                <div class="invalid-feedback" id="passwordMismatch">
                                    Passwords do not match.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="role" class="form-label">
                                    <i class="fas fa-users me-2"></i>Account Type
                                </label>
                                <select class="form-select" id="role" name="role" required>
                                    <option value="ROLE_USER" ${user.role == 'ROLE_USER' ? 'selected' : ''}>Customer</option>
                                    <option value="ROLE_ADMIN" ${user.role == 'ROLE_ADMIN' ? 'selected' : ''}>Restaurant Owner</option>
                                </select>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>Choose Customer to order food, or Restaurant Owner to manage a restaurant
                                </div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">
                                    I agree to the <a href="#" class="text-primary">Terms of Service</a> and 
                                    <a href="#" class="text-primary">Privacy Policy</a>
                                </label>
                                <div class="invalid-feedback">
                                    You must agree to the terms and conditions.
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-user-plus me-2"></i>Create Account
                                </button>
                            </div>
                        </form>

                        <div class="text-center mt-4">
                            <p class="mb-0">Already have an account? 
                                <a href="${pageContext.request.contextPath}/auth/login" class="text-primary text-decoration-none">Login here</a>
                            </p>
                        </div>

                        <hr class="my-4">
                        
                        <div class="text-center">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                                <i class="fas fa-home me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();

        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const toggleIcon = this.querySelector('i');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        });

        // Password strength checker
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrength');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            let text = 'Very Weak';
            let color = '#dc3545';
            
            if (password.length >= 6) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            switch (strength) {
                case 0:
                case 1:
                    text = 'Very Weak';
                    color = '#dc3545';
                    break;
                case 2:
                    text = 'Weak';
                    color = '#fd7e14';
                    break;
                case 3:
                    text = 'Fair';
                    color = '#ffc107';
                    break;
                case 4:
                    text = 'Good';
                    color = '#20c997';
                    break;
                case 5:
                    text = 'Strong';
                    color = '#198754';
                    break;
            }
            
            strengthBar.style.width = (strength * 20) + '%';
            strengthBar.style.backgroundColor = color;
            strengthText.textContent = text;
        });

        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>
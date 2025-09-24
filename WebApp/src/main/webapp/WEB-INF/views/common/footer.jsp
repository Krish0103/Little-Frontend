</main>

    <!-- Footer -->
    <footer class="bg-dark text-light py-5 mt-5">
        <div class="container">
            <div class="row">
                <!-- Brand Section -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <h5 class="mb-3">
                        <i class="fas fa-utensils me-2 text-primary"></i>Swiggaa
                    </h5>
                    <p class="text-muted">
                        Your favorite food delivery platform. Order delicious meals from the best restaurants 
                        in town and get them delivered fresh to your doorstep in minutes!
                    </p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-light fs-5" title="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="text-light fs-5" title="Twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="text-light fs-5" title="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="text-light fs-5" title="LinkedIn">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a href="#" class="text-light fs-5" title="YouTube">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="col-lg-2 col-md-6 mb-4">
                    <h6 class="text-uppercase mb-3">Quick Links</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2">
                            <a href="/" class="text-muted text-decoration-none">
                                <i class="fas fa-home me-1"></i>Home
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="/menu" class="text-muted text-decoration-none">
                                <i class="fas fa-utensils me-1"></i>Menu
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="/orders" class="text-muted text-decoration-none">
                                <i class="fas fa-receipt me-1"></i>My Orders
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="/cart" class="text-muted text-decoration-none">
                                <i class="fas fa-shopping-cart me-1"></i>Cart
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Food Categories -->
                <div class="col-lg-2 col-md-6 mb-4">
                    <h6 class="text-uppercase mb-3">Categories</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2">
                            <a href="/menu/category/Pizza" class="text-muted text-decoration-none">
                                <i class="fas fa-pizza-slice me-1"></i>Pizza
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="/menu/category/Burger" class="text-muted text-decoration-none">
                                <i class="fas fa-hamburger me-1"></i>Burgers
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="/menu/category/Indian" class="text-muted text-decoration-none">
                                <i class="fas fa-pepper-hot me-1"></i>Indian
                            </a>
                        </li>
                        <li class="mb-2">
                            <a href="/menu/vegetarian" class="text-muted text-decoration-none">
                                <i class="fas fa-leaf me-1"></i>Vegetarian
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <h6 class="text-uppercase mb-3">Contact Us</h6>
                    <div class="mb-2">
                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                        <span class="text-muted">123 Food Street, Tech City, Bangalore - 560001</span>
                    </div>
                    <div class="mb-2">
                        <i class="fas fa-phone me-2 text-primary"></i>
                        <a href="tel:+919876543210" class="text-muted text-decoration-none">
                            +91 98765 43210
                        </a>
                    </div>
                    <div class="mb-2">
                        <i class="fas fa-envelope me-2 text-primary"></i>
                        <a href="mailto:support@swiggaa.com" class="text-muted text-decoration-none">
                            support@swiggaa.com
                        </a>
                    </div>
                    <div class="mb-3">
                        <i class="fas fa-clock me-2 text-primary"></i>
                        <span class="text-muted">24/7 Customer Support</span>
                    </div>

                    <!-- Download App -->
                    <div>
                        <p class="mb-2 text-uppercase fw-bold">Download Our App</p>
                        <div class="d-flex gap-2">
                            <a href="#" class="text-decoration-none">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg" 
                                     alt="Get it on Google Play" style="height: 40px;">
                            </a>
                            <a href="#" class="text-decoration-none">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/3/3c/Download_on_the_App_Store_Badge.svg" 
                                     alt="Download on the App Store" style="height: 40px;">
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <hr class="bg-secondary my-4">

            <!-- Bottom Footer -->
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0 text-muted">
                        &copy; 2025 Swiggaa Food Delivery. All rights reserved.
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="d-flex justify-content-md-end gap-3 flex-wrap">
                        <a href="#" class="text-muted text-decoration-none small">Privacy Policy</a>
                        <a href="#" class="text-muted text-decoration-none small">Terms of Service</a>
                        <a href="#" class="text-muted text-decoration-none small">Cookie Policy</a>
                        <a href="#" class="text-muted text-decoration-none small">Help Center</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <button type="button" class="btn btn-primary position-fixed bottom-0 end-0 m-3" 
            id="backToTop" style="display: none; z-index: 1000;">
        <i class="fas fa-chevron-up"></i>
    </button>

    <script>
        // Back to top functionality
        window.addEventListener('scroll', function() {
            const backToTopButton = document.getElementById('backToTop');
            if (window.pageYOffset > 300) {
                backToTopButton.style.display = 'block';
            } else {
                backToTopButton.style.display = 'none';
            }
        });

        document.getElementById('backToTop').addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    </script>
</body>
</html>
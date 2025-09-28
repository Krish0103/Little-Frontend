package com.swiggaa.frontend.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.swiggaa.frontend.service.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        String user = (String) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("loggedInUser", user);
        }
        return "index";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        // Check if user is authenticated
        String user = (String) session.getAttribute("user");
        if (user == null || user.trim().isEmpty()) {
            return "redirect:/auth/login";
        }
        
        String role = (String) session.getAttribute("role");
        
        // Provide default values to prevent JSP errors
        model.addAttribute("loggedInUser", user);
        model.addAttribute("userRole", role != null ? role : "USER");
        
        // Fetch user order statistics
        try {
            Map<String, Object> response = orderService.getOrdersByCustomer(user, session).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> orders = (List<Map<String, Object>>) response.get("data");
                
                if (orders != null) {
                    // Calculate statistics
                    int totalOrders = orders.size();
                    double totalSpent = orders.stream()
                            .mapToDouble(order -> {
                                Object totalAmount = order.get("totalAmount");
                                return totalAmount != null ? ((Number) totalAmount).doubleValue() : 0.0;
                            })
                            .sum();
                    
                    // Count recent orders (you can adjust the logic as needed)
                    long recentOrdersCount = orders.stream()
                            .filter(order -> {
                                String status = (String) order.get("status");
                                return !"DELIVERED".equals(status) && !"CANCELLED".equals(status);
                            })
                            .count();
                    
                    // Add statistics to model
                    model.addAttribute("totalOrders", totalOrders);
                    model.addAttribute("totalSpent", totalSpent);
                    model.addAttribute("recentOrders", recentOrdersCount);
                    model.addAttribute("recentOrdersList", orders.subList(0, Math.min(orders.size(), 3))); // Last 3 orders for display
                } else {
                    // No orders found
                    model.addAttribute("totalOrders", 0);
                    model.addAttribute("totalSpent", 0.0);
                    model.addAttribute("recentOrders", 0);
                }
            } else {
                // Failed to fetch orders
                model.addAttribute("totalOrders", 0);
                model.addAttribute("totalSpent", 0.0);
                model.addAttribute("recentOrders", 0);
            }
        } catch (Exception e) {
            // Error fetching order data
            System.out.println("Error fetching order data for dashboard: " + e.getMessage());
            model.addAttribute("totalOrders", 0);
            model.addAttribute("totalSpent", 0.0);
            model.addAttribute("recentOrders", 0);
        }
        
        // Add debug information
        System.out.println("Dashboard accessed by user: " + user + " with role: " + role);
        
        return "dashboard";
    }
    
    // Test login endpoint - creates a test session for dashboard testing
    @GetMapping("/test-login")
    public String testLogin(HttpSession session) {
        session.setAttribute("user", "testuser");
        session.setAttribute("role", "ROLE_USER");
        return "redirect:/dashboard";
    }
}
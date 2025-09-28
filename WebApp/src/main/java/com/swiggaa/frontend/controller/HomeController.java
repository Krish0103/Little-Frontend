package com.swiggaa.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

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
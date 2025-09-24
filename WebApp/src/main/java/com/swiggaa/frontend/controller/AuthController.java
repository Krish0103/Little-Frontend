package com.swiggaa.frontend.controller;

import com.swiggaa.frontend.model.User;
import com.swiggaa.frontend.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, 
                       @RequestParam String password,
                       HttpSession session, 
                       Model model) {
        try {
            // Add validation for empty parameters
            if (username == null || username.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                model.addAttribute("error", "Username and password are required.");
                return "auth/login";
            }
            
            Map<String, Object> response = authService.login(username, password).block();
            
            if (response != null && Boolean.TRUE.equals(response.get("success"))) {
                session.setAttribute("user", response.get("username"));
                session.setAttribute("token", response.get("token"));
                session.setAttribute("role", response.get("role"));
                return "redirect:../menu";  // Use relative redirect to maintain context path
            } else {
                String errorMessage = response != null ? 
                    (String) response.get("message") : "Login failed. Please try again.";
                model.addAttribute("error", errorMessage);
                return "auth/login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Login failed. Please try again.");
            return "auth/login";
        }
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user, Model model) {
        try {
            // Add validation for required fields
            if (user == null || user.getUsername() == null || user.getUsername().trim().isEmpty() ||
                user.getPassword() == null || user.getPassword().trim().isEmpty() ||
                user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                model.addAttribute("error", "Username, password, and email are required.");
                model.addAttribute("user", user);
                return "auth/register";
            }
            
            Map<String, Object> response = authService.register(user).block();
            
            if (response != null && Boolean.TRUE.equals(response.get("success"))) {
                model.addAttribute("success", "Registration successful! Please login.");
                return "auth/login";
            } else {
                String errorMessage = response != null ? 
                    (String) response.get("message") : "Registration failed. Please try again.";
                model.addAttribute("error", errorMessage);
                model.addAttribute("user", user);
                return "auth/register";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed. Please try again.");
            model.addAttribute("user", user);
            return "auth/register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
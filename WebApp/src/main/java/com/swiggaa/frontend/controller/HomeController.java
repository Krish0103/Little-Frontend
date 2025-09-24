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
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        
        model.addAttribute("loggedInUser", user);
        model.addAttribute("userRole", role);
        
        return "dashboard";
    }
}
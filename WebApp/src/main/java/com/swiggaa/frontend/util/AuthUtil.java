package com.swiggaa.frontend.util;

import org.springframework.http.HttpHeaders;

import jakarta.servlet.http.HttpSession;

public class AuthUtil {
    
    public static HttpHeaders createAuthHeaders(HttpSession session) {
        HttpHeaders headers = new HttpHeaders();
        
        String token = (String) session.getAttribute("token");
        if (token != null && !token.isEmpty()) {
            headers.setBearerAuth(token);
        }
        
        return headers;
    }
    
    public static boolean isAuthenticated(HttpSession session) {
        String token = (String) session.getAttribute("token");
        return token != null && !token.isEmpty();
    }
    
    public static String getUsername(HttpSession session) {
        return (String) session.getAttribute("user");
    }
    
    public static String getRole(HttpSession session) {
        return (String) session.getAttribute("role");
    }
}
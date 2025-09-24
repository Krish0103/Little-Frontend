package com.Swiggaa.auth_service.dto;

import lombok.Data;

@Data
public class AuthResponse {
    private String token;
    private String username;
    private String role;
    private String message;
    
    // Constructor with only message (for error cases)
    public AuthResponse(String message) {
        this.message = message;
    }
    
    // Constructor for all 4 parameters (token, username, role, message)
    public AuthResponse(String token, String username, String role, String message) {
        this.token = token;
        this.username = username;
        this.role = role;
        this.message = message;
    }
    
    // Explicit getters to ensure they exist
    public String getToken() {
        return token;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getRole() {
        return role;
    }
    
    public String getMessage() {
        return message;
    }
    
    // Explicit setters
    public void setToken(String token) {
        this.token = token;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
}
package com.Swiggaa.auth_service.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class TokenValidationRequest {
    @NotBlank(message = "Token is required")
    private String token;
    
    // Explicit getter and setter to ensure they exist
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
}
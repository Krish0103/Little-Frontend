package com.Swiggaa.auth_service.dto;

import lombok.Data;

@Data
public class UserProfileResponse {
    private String username;
    private String email;
    private String phone;
    private String address;
    private String role;
    private String message;
    
    // Constructor for error cases
    public UserProfileResponse(String message) {
        this.message = message;
    }
    
    // Constructor for success cases
    public UserProfileResponse(String username, String email, String phone, String address, String role, String message) {
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.message = message;
    }
}
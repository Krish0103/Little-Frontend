package com.Swiggaa.auth_service.service;

import com.Swiggaa.auth_service.dto.*;
import com.Swiggaa.auth_service.model.User;
import com.Swiggaa.auth_service.repository.UserRepository;
import com.Swiggaa.auth_service.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByUsername(request.getUsername())) {
            return new AuthResponse("Username already exists");
        }
        
        // Check if email already exists
        if (userRepository.existsByEmail(request.getEmail())) {
            return new AuthResponse("Email already exists");
        }
        
        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        user.setAddress(request.getAddress());
        user.setRole(request.getRole());
        
        userRepository.save(user);
        
        String token = jwtUtil.generateToken(user.getUsername(), user.getRole());
        return new AuthResponse(token, user.getUsername(), user.getRole(), "User registered successfully");
    }
    
    public AuthResponse login(LoginRequest request) {
        Optional<User> userOptional = userRepository.findByUsername(request.getUsername());
        
        if (userOptional.isEmpty()) {
            return new AuthResponse("Invalid username or password");
        }
        
        User user = userOptional.get();
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            return new AuthResponse("Invalid username or password");
        }
        
        String token = jwtUtil.generateToken(user.getUsername(), user.getRole());
        return new AuthResponse(token, user.getUsername(), user.getRole(), "Login successful");
    }
    
    public AuthResponse validateToken(String token) {
        if (jwtUtil.validateToken(token) && !jwtUtil.isTokenExpired(token)) {
            String username = jwtUtil.getUsernameFromToken(token);
            String role = jwtUtil.getRoleFromToken(token);
            return new AuthResponse(token, username, role, "Token is valid");
        }
        return new AuthResponse("Invalid or expired token");
    }
    
    public UserProfileResponse getUserProfile(String username) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        
        if (userOptional.isEmpty()) {
            return new UserProfileResponse("User not found");
        }
        
        User user = userOptional.get();
        return new UserProfileResponse(
            user.getUsername(),
            user.getEmail(),
            user.getPhone(),
            user.getAddress(),
            user.getRole(),
            "Profile retrieved successfully"
        );
    }
}
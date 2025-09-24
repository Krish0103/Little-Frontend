package com.swiggaa.frontend.service;

import com.swiggaa.frontend.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.HashMap;

@Service
public class AuthService {

    @Autowired
    @Qualifier("authServiceWebClient")
    private WebClient authWebClient;

    public Mono<Map<String, Object>> login(String username, String password) {
        Map<String, String> loginRequest = Map.of(
            "username", username,
            "password", password
        );

        return authWebClient.post()
                .uri("/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(loginRequest)
                .retrieve()
                .bodyToMono(Map.class)
                .map(response -> {
                    Map<String, Object> result = new HashMap<>();
                    // Check if response has token (success) or just message (error)
                    if (response.get("token") != null) {
                        result.put("success", true);
                        result.put("token", response.get("token"));
                        result.put("username", response.get("username"));
                        result.put("role", response.get("role"));
                        result.put("message", response.get("message"));
                    } else {
                        result.put("success", false);
                        result.put("message", response.get("message"));
                    }
                    return result;
                })
                .onErrorReturn(Map.of("success", false, "message", "Login failed"));
    }

    public Mono<Map<String, Object>> register(User user) {
        Map<String, String> registerRequest = Map.of(
            "username", user.getUsername(),
            "password", user.getPassword(),
            "email", user.getEmail() != null ? user.getEmail() : "",
            "phone", user.getPhone() != null ? user.getPhone() : "",
            "address", user.getAddress() != null ? user.getAddress() : "",
            "role", user.getRole() != null ? user.getRole() : "ROLE_USER"
        );

        return authWebClient.post()
                .uri("/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(registerRequest)
                .retrieve()
                .bodyToMono(Map.class)
                .map(response -> {
                    Map<String, Object> result = new HashMap<>();
                    // Check if response has token (success) or just message (error)
                    if (response.get("token") != null) {
                        result.put("success", true);
                        result.put("token", response.get("token"));
                        result.put("username", response.get("username"));
                        result.put("role", response.get("role"));
                        result.put("message", response.get("message"));
                    } else {
                        result.put("success", false);
                        result.put("message", response.get("message"));
                    }
                    return result;
                })
                .onErrorReturn(Map.of("success", false, "message", "Registration failed"));
    }

    public Mono<Map<String, Object>> validateToken(String token) {
        Map<String, String> tokenRequest = Map.of("token", token);

        return authWebClient.post()
                .uri("/auth/validate")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(tokenRequest)
                .retrieve()
                .bodyToMono(Map.class)
                .map(response -> {
                    Map<String, Object> result = new HashMap<>();
                    // Check if response has token (success) or just message (error)
                    if (response.get("token") != null) {
                        result.put("success", true);
                        result.put("token", response.get("token"));
                        result.put("username", response.get("username"));
                        result.put("role", response.get("role"));
                        result.put("message", response.get("message"));
                    } else {
                        result.put("success", false);
                        result.put("message", response.get("message"));
                    }
                    return result;
                })
                .onErrorReturn(Map.of("success", false, "message", "Invalid token"));
    }
}
package com.swiggaa.frontend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.HashMap;

@Service
public class UserService {

    @Autowired
    @Qualifier("authServiceWebClient")
    private WebClient authWebClient;

    public Mono<Map<String, Object>> getUserProfile(String username) {
        return authWebClient.get()
                .uri("/auth/profile/" + username)
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .bodyToMono(Map.class)
                .map(response -> {
                    Map<String, Object> result = new HashMap<>();
                    if (response.get("username") != null) {
                        result.put("success", true);
                        result.put("username", response.get("username"));
                        result.put("email", response.get("email"));
                        result.put("phone", response.get("phone"));
                        result.put("address", response.get("address"));
                        result.put("role", response.get("role"));
                        result.put("message", response.get("message"));
                    } else {
                        result.put("success", false);
                        result.put("message", response.get("message"));
                    }
                    return result;
                })
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch user profile"));
    }
}
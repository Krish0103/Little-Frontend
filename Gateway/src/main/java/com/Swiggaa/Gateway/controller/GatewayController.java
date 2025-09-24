package com.Swiggaa.Gateway.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/gateway")
public class GatewayController {

    @GetMapping("/health")
    public Mono<Map<String, Object>> health() {
        Map<String, Object> health = new HashMap<>();
        health.put("status", "UP");
        health.put("message", "Gateway is running with Eureka service discovery");
        health.put("timestamp", System.currentTimeMillis());
        
        Map<String, String> services = new HashMap<>();
        services.put("auth-service", "Registered with Eureka (lb://auth-service)");
        services.put("menu-service", "Registered with Eureka (lb://menu-service)");
        services.put("order-service", "Registered with Eureka (lb://order-service)");
        services.put("eureka-server", "http://localhost:8761/eureka/");
        
        health.put("services", services);
        return Mono.just(health);
    }

    @GetMapping("/routes")
    public Mono<Map<String, Object>> routes() {
        Map<String, Object> routes = new HashMap<>();
        
        Map<String, String> apiRoutes = new HashMap<>();
        apiRoutes.put("Authentication", "POST /api/auth/register, POST /api/auth/login");
        apiRoutes.put("Menu Management", "GET /api/menu/items, POST /api/menu/items");
        apiRoutes.put("Order Management", "GET /api/orders, POST /api/orders");
        
        routes.put("Available API Routes", apiRoutes);
        routes.put("Gateway Port", "8080");
        routes.put("Service Discovery", "Eureka Server at localhost:8761");
        routes.put("Documentation", "Use these endpoints through the gateway at localhost:8080");
        
        return Mono.just(routes);
    }
}
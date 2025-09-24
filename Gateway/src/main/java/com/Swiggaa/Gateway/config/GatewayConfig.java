package com.Swiggaa.Gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                // Auth Service Routes - API paths with prefix stripping
                .route("auth-service-api", r -> r.path("/api/auth/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://auth-service"))
                
                // Auth Service Routes - Direct paths
                .route("auth-service-direct", r -> r.path("/auth/**")
                        .uri("lb://auth-service"))
                
                // Menu Service Routes - API paths with prefix stripping
                .route("menu-service-api", r -> r.path("/api/menu/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://menu-service"))
                
                // Menu Service Routes - Direct paths
                .route("menu-service-direct", r -> r.path("/menu/**")
                        .uri("lb://menu-service"))
                
                // Order Service Routes - API paths with prefix stripping
                .route("order-service-api", r -> r.path("/api/orders/**")
                        .filters(f -> f.stripPrefix(1))
                        .uri("lb://order-service"))
                
                // Order Service Routes - Direct paths
                .route("order-service-direct", r -> r.path("/orders/**")
                        .uri("lb://order-service"))
                
                .build();
    }

    @Bean
    public CorsWebFilter corsWebFilter() {
        CorsConfiguration corsConfig = new CorsConfiguration();
        corsConfig.setAllowCredentials(true);
        corsConfig.addAllowedOriginPattern("*");
        corsConfig.addAllowedHeader("*");
        corsConfig.addAllowedMethod("*");

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfig);

        return new CorsWebFilter(source);
    }
}
package com.swiggaa.frontend.service;

import com.swiggaa.frontend.model.Order;
import com.swiggaa.frontend.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Map;

@Service
public class OrderService {

    @Autowired
    @Qualifier("orderServiceWebClient")
    private WebClient orderWebClient;
    
    private final ParameterizedTypeReference<Map<String, Object>> mapType = 
        new ParameterizedTypeReference<Map<String, Object>>() {};

    public Mono<Map<String, Object>> createOrder(Order order, HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.post()
                .uri("/orders")
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(order)
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to create order"));
    }
    
    public Mono<Map<String, Object>> createOrderRequest(Map<String, Object> orderRequest, HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.post()
                .uri("/orders")
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(orderRequest)
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to create order"));
    }

    public Mono<Map<String, Object>> getOrderById(Long orderId, HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.get()
                .uri("/orders/{id}", orderId)
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .retrieve()
                .bodyToMono(mapType)
                .doOnError(throwable -> {
                    System.err.println("Error fetching order " + orderId + ": " + throwable.getMessage());
                })
                .onErrorReturn(Map.of("success", false, "message", "Unable to load order details. Please try again later."));
    }

    public Mono<Map<String, Object>> getOrdersByCustomer(String customerUsername, HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.get()
                .uri("/orders/customer/{customerUsername}", customerUsername)
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .retrieve()
                .bodyToMono(mapType)
                .doOnError(throwable -> {
                    System.err.println("Error fetching orders for customer " + customerUsername + ": " + throwable.getMessage());
                })
                .onErrorReturn(Map.of("success", false, "message", "Unable to connect to order service. Please try again later."));
    }

    public Mono<Map<String, Object>> getAllOrders(HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.get()
                .uri("/orders")
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch orders"));
    }

    public Mono<Map<String, Object>> cancelOrder(Long orderId, HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.put()
                .uri("/orders/{id}/cancel", orderId)
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to cancel order"));
    }

    public Mono<Map<String, Object>> updateOrderStatus(Long orderId, String status, HttpSession session) {
        HttpHeaders headers = AuthUtil.createAuthHeaders(session);
        
        return orderWebClient.put()
                .uri("/orders/{id}/status?status={status}", orderId, status)
                .headers(httpHeaders -> httpHeaders.addAll(headers))
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to update order status"));
    }
}
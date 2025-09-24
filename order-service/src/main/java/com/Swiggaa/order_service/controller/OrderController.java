package com.Swiggaa.order_service.controller;

import com.Swiggaa.order_service.dto.OrderRequest;
import com.Swiggaa.order_service.dto.OrderResponse;
import com.Swiggaa.order_service.model.OrderStatus;
import com.Swiggaa.order_service.service.OrderService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
@CrossOrigin(origins = "*")
public class OrderController {
    
    @Autowired
    private OrderService orderService;
    
    @PostMapping
    public ResponseEntity<OrderResponse> createOrder(@Valid @RequestBody OrderRequest request) {
        OrderResponse response = orderService.createOrder(request);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<OrderResponse> getOrderById(@PathVariable Long id) {
        OrderResponse response = orderService.getOrderById(id);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/customer/{customerUsername}")
    public ResponseEntity<OrderResponse> getOrdersByCustomer(@PathVariable String customerUsername) {
        OrderResponse response = orderService.getOrdersByCustomer(customerUsername);
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/restaurant/{restaurantId}")
    public ResponseEntity<OrderResponse> getOrdersByRestaurant(@PathVariable Long restaurantId) {
        OrderResponse response = orderService.getOrdersByRestaurant(restaurantId);
        return ResponseEntity.ok(response);
    }
    
    @PutMapping("/{id}/status")
    public ResponseEntity<OrderResponse> updateOrderStatus(@PathVariable Long id, @RequestParam OrderStatus status) {
        OrderResponse response = orderService.updateOrderStatus(id, status);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    @GetMapping
    public ResponseEntity<OrderResponse> getAllOrders() {
        OrderResponse response = orderService.getAllOrders();
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/active")
    public ResponseEntity<OrderResponse> getActiveOrders() {
        OrderResponse response = orderService.getActiveOrders();
        return ResponseEntity.ok(response);
    }
    
    @PutMapping("/{id}/cancel")
    public ResponseEntity<OrderResponse> cancelOrder(@PathVariable Long id) {
        OrderResponse response = orderService.cancelOrder(id);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
}
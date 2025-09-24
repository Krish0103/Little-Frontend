package com.Swiggaa.order_service.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class OrderRequest {
    @NotBlank(message = "Customer username is required")
    private String customerUsername;
    
    @NotNull(message = "Restaurant ID is required")
    private Long restaurantId;
    
    private String restaurantName;
    
    @NotEmpty(message = "Order items cannot be empty")
    private List<OrderItemRequest> orderItems;
    
    @NotBlank(message = "Delivery address is required")
    private String deliveryAddress;
    
    @NotBlank(message = "Phone number is required")
    private String phoneNumber;
    
    @NotBlank(message = "Payment method is required")
    private String paymentMethod;
    
    private String specialInstructions;
}
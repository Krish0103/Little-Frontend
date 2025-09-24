package com.Swiggaa.order_service.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderResponse {
    private String message;
    private Object data;
    private boolean success;
    
    public OrderResponse(String message) {
        this.message = message;
        this.success = false;
    }
    
    public OrderResponse(Object data) {
        this.data = data;
        this.success = true;
        this.message = "Operation successful";
    }
}
package com.Swiggaa.menu_service.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class MenuResponse {
    private String message;
    private Object data;
    private boolean success;
    
    public MenuResponse(String message) {
        this.message = message;
        this.success = false;
    }
    
    public MenuResponse(Object data) {
        this.data = data;
        this.success = true;
        this.message = "Operation successful";
    }
}
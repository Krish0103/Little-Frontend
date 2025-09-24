package com.Swiggaa.menu_service.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class MenuItemRequest {
    @NotBlank(message = "Name is required")
    private String name;
    
    private String description;
    
    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    private BigDecimal price;
    
    @NotBlank(message = "Category is required")
    private String category;
    
    @NotNull(message = "Restaurant ID is required")
    private Long restaurantId;
    
    private String restaurantName;
    
    private boolean available = true;
    
    private String imageUrl;
    
    private boolean vegetarian = false;
    
    private boolean vegan = false;
    
    private boolean glutenFree = false;
    
    private int preparationTime = 30; // default 30 minutes
}
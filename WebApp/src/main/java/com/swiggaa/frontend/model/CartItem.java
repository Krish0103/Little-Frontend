package com.swiggaa.frontend.model;

import java.math.BigDecimal;

public class CartItem {
    private Long menuItemId;
    private String menuItemName;
    private BigDecimal price;
    private int quantity;
    private BigDecimal subtotal;
    private String imageUrl;
    private String category;
    
    // Constructors
    public CartItem() {}
    
    public CartItem(MenuItem menuItem, int quantity) {
        this.menuItemId = menuItem.getId();
        this.menuItemName = menuItem.getName();
        this.price = menuItem.getPrice();
        this.quantity = quantity;
        this.imageUrl = menuItem.getImageUrl();
        this.category = menuItem.getCategory();
        calculateSubtotal();
    }
    
    public void calculateSubtotal() {
        if (price != null) {
            this.subtotal = price.multiply(BigDecimal.valueOf(quantity));
        }
    }
    
    // Getters and Setters
    public Long getMenuItemId() { return menuItemId; }
    public void setMenuItemId(Long menuItemId) { this.menuItemId = menuItemId; }
    
    public String getMenuItemName() { return menuItemName; }
    public void setMenuItemName(String menuItemName) { this.menuItemName = menuItemName; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { 
        this.price = price; 
        calculateSubtotal();
    }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { 
        this.quantity = quantity; 
        calculateSubtotal();
    }
    
    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
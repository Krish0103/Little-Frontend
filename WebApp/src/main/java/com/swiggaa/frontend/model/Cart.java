package com.swiggaa.frontend.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;
    private BigDecimal totalAmount;
    
    public Cart() {
        this.items = new ArrayList<>();
        this.totalAmount = BigDecimal.ZERO;
    }
    
    public void addItem(MenuItem menuItem, int quantity) {
        // Check if item already exists in cart
        for (CartItem item : items) {
            if (item.getMenuItemId().equals(menuItem.getId())) {
                item.setQuantity(item.getQuantity() + quantity);
                calculateTotal();
                return;
            }
        }
        
        // Add new item
        CartItem cartItem = new CartItem(menuItem, quantity);
        items.add(cartItem);
        calculateTotal();
    }
    
    public void removeItem(Long menuItemId) {
        items.removeIf(item -> item.getMenuItemId().equals(menuItemId));
        calculateTotal();
    }
    
    public void updateItemQuantity(Long menuItemId, int quantity) {
        for (CartItem item : items) {
            if (item.getMenuItemId().equals(menuItemId)) {
                if (quantity <= 0) {
                    removeItem(menuItemId);
                } else {
                    item.setQuantity(quantity);
                    calculateTotal();
                }
                break;
            }
        }
    }
    
    public void clear() {
        items.clear();
        totalAmount = BigDecimal.ZERO;
    }
    
    private void calculateTotal() {
        totalAmount = items.stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    public int getItemCount() {
        return items.stream().mapToInt(CartItem::getQuantity).sum();
    }
    
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    // Getters and Setters
    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { 
        this.items = items; 
        calculateTotal();
    }
    
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    // Convert cart items to order items
    public List<OrderItem> convertToOrderItems() {
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : items) {
            OrderItem orderItem = new OrderItem();
            orderItem.setMenuItemId(cartItem.getMenuItemId());
            orderItem.setMenuItemName(cartItem.getMenuItemName());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getPrice());
            orderItem.setSubtotal(cartItem.getSubtotal());
            orderItems.add(orderItem);
        }
        return orderItems;
    }
}
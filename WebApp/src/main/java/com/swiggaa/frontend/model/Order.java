package com.swiggaa.frontend.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private Long id;
    private Long userId;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String deliveryAddress;
    private BigDecimal totalAmount;
    private String status;
    private LocalDateTime orderDate;
    private LocalDateTime deliveryTime;
    private List<OrderItem> items;
    private String paymentMethod;
    private String specialInstructions;
    
    // Constructors
    public Order() {}
    
    public Order(Long userId, String customerName, String customerEmail, 
                 String customerPhone, String deliveryAddress) {
        this.userId = userId;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPhone = customerPhone;
        this.deliveryAddress = deliveryAddress;
        this.status = "PENDING";
        this.orderDate = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
    
    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    
    // Additional setters for compatibility
    public void setCustomerUsername(String customerUsername) { this.customerName = customerUsername; }
    public void setPhoneNumber(String phoneNumber) { this.customerPhone = phoneNumber; }
    
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }
    
    // Getter for JSP compatibility - converts LocalDateTime to Date for fmt:formatDate
    public java.util.Date getOrderTime() { 
        return orderDate != null ? java.sql.Timestamp.valueOf(orderDate) : null; 
    }
    
    // Setter for backend compatibility - converts string to LocalDateTime
    public void setOrderTime(Object orderTime) {
        if (orderTime instanceof String) {
            try {
                this.orderDate = java.time.LocalDateTime.parse((String) orderTime);
            } catch (Exception e) {
                System.err.println("Error parsing orderTime: " + orderTime + " - " + e.getMessage());
            }
        } else if (orderTime instanceof java.time.LocalDateTime) {
            this.orderDate = (java.time.LocalDateTime) orderTime;
        }
    }
    
    public LocalDateTime getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(LocalDateTime deliveryTime) { this.deliveryTime = deliveryTime; }
    
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
    
    // Additional setters for compatibility
    public void setOrderItems(List<OrderItem> orderItems) { this.items = orderItems; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getSpecialInstructions() { return specialInstructions; }
    public void setSpecialInstructions(String specialInstructions) { this.specialInstructions = specialInstructions; }
}
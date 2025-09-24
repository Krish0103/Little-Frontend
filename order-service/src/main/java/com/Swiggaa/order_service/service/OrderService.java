package com.Swiggaa.order_service.service;

import com.Swiggaa.order_service.dto.OrderItemRequest;
import com.Swiggaa.order_service.dto.OrderRequest;
import com.Swiggaa.order_service.dto.OrderResponse;
import com.Swiggaa.order_service.model.Order;
import com.Swiggaa.order_service.model.OrderItem;
import com.Swiggaa.order_service.model.OrderStatus;
import com.Swiggaa.order_service.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    public OrderResponse createOrder(OrderRequest request) {
        try {
            Order order = new Order();
            order.setCustomerUsername(request.getCustomerUsername());
            order.setRestaurantId(request.getRestaurantId());
            order.setRestaurantName(request.getRestaurantName());
            order.setDeliveryAddress(request.getDeliveryAddress());
            order.setPhoneNumber(request.getPhoneNumber());
            order.setPaymentMethod(request.getPaymentMethod());
            order.setSpecialInstructions(request.getSpecialInstructions());
            order.setStatus(OrderStatus.PLACED);
            order.setOrderTime(LocalDateTime.now());
            
            // Convert OrderItemRequests to OrderItems
            List<OrderItem> orderItems = request.getOrderItems().stream()
                .map(itemRequest -> {
                    OrderItem item = new OrderItem();
                    item.setMenuItemId(itemRequest.getMenuItemId());
                    item.setItemName(itemRequest.getItemName());
                    item.setItemPrice(itemRequest.getItemPrice());
                    item.setQuantity(itemRequest.getQuantity());
                    item.setSubtotal(itemRequest.getItemPrice().multiply(BigDecimal.valueOf(itemRequest.getQuantity())));
                    return item;
                }).collect(Collectors.toList());
            
            order.setOrderItems(orderItems);
            
            // Calculate total amount
            BigDecimal totalAmount = orderItems.stream()
                .map(OrderItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            order.setTotalAmount(totalAmount);
            
            Order savedOrder = orderRepository.save(order);
            return new OrderResponse(savedOrder);
            
        } catch (Exception e) {
            return new OrderResponse("Failed to create order: " + e.getMessage());
        }
    }
    
    public OrderResponse getOrderById(Long id) {
        try {
            Optional<Order> order = orderRepository.findById(id);
            if (order.isPresent()) {
                return new OrderResponse(order.get());
            } else {
                return new OrderResponse("Order not found with id: " + id);
            }
        } catch (Exception e) {
            return new OrderResponse("Failed to fetch order: " + e.getMessage());
        }
    }
    
    public OrderResponse getOrdersByCustomer(String customerUsername) {
        try {
            List<Order> orders = orderRepository.findByCustomerUsernameOrderByOrderTimeDesc(customerUsername);
            return new OrderResponse(orders);
        } catch (Exception e) {
            return new OrderResponse("Failed to fetch orders: " + e.getMessage());
        }
    }
    
    public OrderResponse getOrdersByRestaurant(Long restaurantId) {
        try {
            List<Order> orders = orderRepository.findByRestaurantIdOrderByOrderTimeDesc(restaurantId);
            return new OrderResponse(orders);
        } catch (Exception e) {
            return new OrderResponse("Failed to fetch orders for restaurant: " + e.getMessage());
        }
    }
    
    public OrderResponse updateOrderStatus(Long orderId, OrderStatus status) {
        try {
            Optional<Order> orderOptional = orderRepository.findById(orderId);
            if (orderOptional.isPresent()) {
                Order order = orderOptional.get();
                order.setStatus(status);
                
                // Set delivery time if order is delivered
                if (status == OrderStatus.DELIVERED) {
                    order.setDeliveryTime(LocalDateTime.now());
                }
                
                Order updatedOrder = orderRepository.save(order);
                return new OrderResponse(updatedOrder);
            } else {
                return new OrderResponse("Order not found with id: " + orderId);
            }
        } catch (Exception e) {
            return new OrderResponse("Failed to update order status: " + e.getMessage());
        }
    }
    
    public OrderResponse getAllOrders() {
        try {
            List<Order> orders = orderRepository.findAll();
            return new OrderResponse(orders);
        } catch (Exception e) {
            return new OrderResponse("Failed to fetch orders: " + e.getMessage());
        }
    }
    
    public OrderResponse getActiveOrders() {
        try {
            List<Order> activeOrders = orderRepository.findActiveOrders();
            return new OrderResponse(activeOrders);
        } catch (Exception e) {
            return new OrderResponse("Failed to fetch active orders: " + e.getMessage());
        }
    }
    
    public OrderResponse cancelOrder(Long orderId) {
        try {
            Optional<Order> orderOptional = orderRepository.findById(orderId);
            if (orderOptional.isPresent()) {
                Order order = orderOptional.get();
                if (order.getStatus() == OrderStatus.DELIVERED) {
                    return new OrderResponse("Cannot cancel a delivered order");
                }
                order.setStatus(OrderStatus.CANCELLED);
                Order updatedOrder = orderRepository.save(order);
                return new OrderResponse(updatedOrder);
            } else {
                return new OrderResponse("Order not found with id: " + orderId);
            }
        } catch (Exception e) {
            return new OrderResponse("Failed to cancel order: " + e.getMessage());
        }
    }
}
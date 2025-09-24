package com.Swiggaa.order_service.repository;

import com.Swiggaa.order_service.model.Order;
import com.Swiggaa.order_service.model.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    
    // Find orders by customer username
    List<Order> findByCustomerUsernameOrderByOrderTimeDesc(String customerUsername);
    
    // Find orders by restaurant ID
    List<Order> findByRestaurantIdOrderByOrderTimeDesc(Long restaurantId);
    
    // Find orders by status
    List<Order> findByStatus(OrderStatus status);
    
    // Find orders by customer and status
    List<Order> findByCustomerUsernameAndStatus(String customerUsername, OrderStatus status);
    
    // Find orders by restaurant and status
    List<Order> findByRestaurantIdAndStatus(Long restaurantId, OrderStatus status);
    
    // Find orders within a date range
    @Query("SELECT o FROM Order o WHERE o.orderTime BETWEEN :startDate AND :endDate ORDER BY o.orderTime DESC")
    List<Order> findOrdersWithinDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
    
    // Find recent orders (last 24 hours) for a customer
    @Query("SELECT o FROM Order o WHERE o.customerUsername = :username AND o.orderTime >= :since ORDER BY o.orderTime DESC")
    List<Order> findRecentOrdersByCustomer(@Param("username") String username, @Param("since") LocalDateTime since);
    
    // Find active orders (not delivered or cancelled)
    @Query("SELECT o FROM Order o WHERE o.status NOT IN ('DELIVERED', 'CANCELLED') ORDER BY o.orderTime DESC")
    List<Order> findActiveOrders();
}
package com.Swiggaa.menu_service.repository;

import com.Swiggaa.menu_service.model.MenuItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuItemRepository extends JpaRepository<MenuItem, Long> {
    
    // Find all menu items for a specific restaurant
    List<MenuItem> findByRestaurantId(Long restaurantId);
    
    // Find available menu items for a restaurant
    List<MenuItem> findByRestaurantIdAndAvailableTrue(Long restaurantId);
    
    // Find menu items by category
    List<MenuItem> findByCategory(String category);
    
    // Find menu items by category for a specific restaurant
    List<MenuItem> findByRestaurantIdAndCategory(Long restaurantId, String category);
    
    // Find vegetarian items
    List<MenuItem> findByVegetarianTrue();
    
    // Find vegan items
    List<MenuItem> findByVeganTrue();
    
    // Search menu items by name (case-insensitive)
    @Query("SELECT m FROM MenuItem m WHERE LOWER(m.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<MenuItem> findByNameContainingIgnoreCase(@Param("name") String name);
    
    // Search menu items by name for a specific restaurant
    @Query("SELECT m FROM MenuItem m WHERE m.restaurantId = :restaurantId AND LOWER(m.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<MenuItem> findByRestaurantIdAndNameContainingIgnoreCase(@Param("restaurantId") Long restaurantId, @Param("name") String name);
    
    // Find all available menu items
    List<MenuItem> findByAvailableTrue();
}
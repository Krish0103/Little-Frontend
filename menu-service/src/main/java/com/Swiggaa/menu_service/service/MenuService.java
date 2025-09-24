package com.Swiggaa.menu_service.service;

import com.Swiggaa.menu_service.dto.MenuItemRequest;
import com.Swiggaa.menu_service.dto.MenuResponse;
import com.Swiggaa.menu_service.model.MenuItem;
import com.Swiggaa.menu_service.repository.MenuItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MenuService {
    
    @Autowired
    private MenuItemRepository menuItemRepository;
    
    public MenuResponse createMenuItem(MenuItemRequest request) {
        try {
            MenuItem menuItem = new MenuItem();
            menuItem.setName(request.getName());
            menuItem.setDescription(request.getDescription());
            menuItem.setPrice(request.getPrice());
            menuItem.setCategory(request.getCategory());
            menuItem.setRestaurantId(request.getRestaurantId());
            menuItem.setRestaurantName(request.getRestaurantName());
            menuItem.setAvailable(request.isAvailable());
            menuItem.setImageUrl(request.getImageUrl());
            menuItem.setVegetarian(request.isVegetarian());
            menuItem.setVegan(request.isVegan());
            menuItem.setGlutenFree(request.isGlutenFree());
            menuItem.setPreparationTime(request.getPreparationTime());
            
            MenuItem savedItem = menuItemRepository.save(menuItem);
            return new MenuResponse(savedItem);
        } catch (Exception e) {
            return new MenuResponse("Failed to create menu item: " + e.getMessage());
        }
    }
    
    public MenuResponse getAllMenuItems() {
        try {
            List<MenuItem> menuItems = menuItemRepository.findAll();
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch menu items: " + e.getMessage());
        }
    }
    
    public MenuResponse getMenuItemById(Long id) {
        try {
            Optional<MenuItem> menuItem = menuItemRepository.findById(id);
            if (menuItem.isPresent()) {
                return new MenuResponse(menuItem.get());
            } else {
                return new MenuResponse("Menu item not found with id: " + id);
            }
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch menu item: " + e.getMessage());
        }
    }
    
    public MenuResponse getMenuItemsByRestaurant(Long restaurantId) {
        try {
            List<MenuItem> menuItems = menuItemRepository.findByRestaurantIdAndAvailableTrue(restaurantId);
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch menu items for restaurant: " + e.getMessage());
        }
    }
    
    public MenuResponse getMenuItemsByCategory(String category) {
        try {
            List<MenuItem> menuItems = menuItemRepository.findByCategory(category);
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch menu items by category: " + e.getMessage());
        }
    }
    
    public MenuResponse getMenuItemsByRestaurantAndCategory(Long restaurantId, String category) {
        try {
            List<MenuItem> menuItems = menuItemRepository.findByRestaurantIdAndCategory(restaurantId, category);
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch menu items: " + e.getMessage());
        }
    }
    
    public MenuResponse searchMenuItems(String name) {
        try {
            List<MenuItem> menuItems = menuItemRepository.findByNameContainingIgnoreCase(name);
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to search menu items: " + e.getMessage());
        }
    }
    
    public MenuResponse updateMenuItem(Long id, MenuItemRequest request) {
        try {
            Optional<MenuItem> existingItem = menuItemRepository.findById(id);
            if (existingItem.isPresent()) {
                MenuItem menuItem = existingItem.get();
                menuItem.setName(request.getName());
                menuItem.setDescription(request.getDescription());
                menuItem.setPrice(request.getPrice());
                menuItem.setCategory(request.getCategory());
                menuItem.setAvailable(request.isAvailable());
                menuItem.setImageUrl(request.getImageUrl());
                menuItem.setVegetarian(request.isVegetarian());
                menuItem.setVegan(request.isVegan());
                menuItem.setGlutenFree(request.isGlutenFree());
                menuItem.setPreparationTime(request.getPreparationTime());
                
                MenuItem updatedItem = menuItemRepository.save(menuItem);
                return new MenuResponse(updatedItem);
            } else {
                return new MenuResponse("Menu item not found with id: " + id);
            }
        } catch (Exception e) {
            return new MenuResponse("Failed to update menu item: " + e.getMessage());
        }
    }
    
    public MenuResponse deleteMenuItem(Long id) {
        try {
            if (menuItemRepository.existsById(id)) {
                menuItemRepository.deleteById(id);
                return new MenuResponse("Menu item deleted successfully", null, true);
            } else {
                return new MenuResponse("Menu item not found with id: " + id);
            }
        } catch (Exception e) {
            return new MenuResponse("Failed to delete menu item: " + e.getMessage());
        }
    }
    
    public MenuResponse getVegetarianItems() {
        try {
            List<MenuItem> menuItems = menuItemRepository.findByVegetarianTrue();
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch vegetarian items: " + e.getMessage());
        }
    }
    
    public MenuResponse getVeganItems() {
        try {
            List<MenuItem> menuItems = menuItemRepository.findByVeganTrue();
            return new MenuResponse(menuItems);
        } catch (Exception e) {
            return new MenuResponse("Failed to fetch vegan items: " + e.getMessage());
        }
    }
}
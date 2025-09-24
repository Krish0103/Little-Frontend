package com.Swiggaa.menu_service.controller;

import com.Swiggaa.menu_service.dto.MenuItemRequest;
import com.Swiggaa.menu_service.dto.MenuResponse;
import com.Swiggaa.menu_service.service.MenuService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/menu")
@CrossOrigin(origins = "*")
public class MenuController {
    
    @Autowired
    private MenuService menuService;
    
    @PostMapping("/items")
    public ResponseEntity<MenuResponse> createMenuItem(@Valid @RequestBody MenuItemRequest request) {
        MenuResponse response = menuService.createMenuItem(request);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    @GetMapping("/items")
    public ResponseEntity<MenuResponse> getAllMenuItems() {
        MenuResponse response = menuService.getAllMenuItems();
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/items/{id}")
    public ResponseEntity<MenuResponse> getMenuItemById(@PathVariable Long id) {
        MenuResponse response = menuService.getMenuItemById(id);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/restaurant/{restaurantId}")
    public ResponseEntity<MenuResponse> getMenuItemsByRestaurant(@PathVariable Long restaurantId) {
        MenuResponse response = menuService.getMenuItemsByRestaurant(restaurantId);
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/category/{category}")
    public ResponseEntity<MenuResponse> getMenuItemsByCategory(@PathVariable String category) {
        MenuResponse response = menuService.getMenuItemsByCategory(category);
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/restaurant/{restaurantId}/category/{category}")
    public ResponseEntity<MenuResponse> getMenuItemsByRestaurantAndCategory(
            @PathVariable Long restaurantId, 
            @PathVariable String category) {
        MenuResponse response = menuService.getMenuItemsByRestaurantAndCategory(restaurantId, category);
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/search")
    public ResponseEntity<MenuResponse> searchMenuItems(@RequestParam String name) {
        MenuResponse response = menuService.searchMenuItems(name);
        return ResponseEntity.ok(response);
    }
    
    @PutMapping("/items/{id}")
    public ResponseEntity<MenuResponse> updateMenuItem(@PathVariable Long id, @Valid @RequestBody MenuItemRequest request) {
        MenuResponse response = menuService.updateMenuItem(id, request);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
    
    @DeleteMapping("/items/{id}")
    public ResponseEntity<MenuResponse> deleteMenuItem(@PathVariable Long id) {
        MenuResponse response = menuService.deleteMenuItem(id);
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/vegetarian")
    public ResponseEntity<MenuResponse> getVegetarianItems() {
        MenuResponse response = menuService.getVegetarianItems();
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/vegan")
    public ResponseEntity<MenuResponse> getVeganItems() {
        MenuResponse response = menuService.getVeganItems();
        return ResponseEntity.ok(response);
    }
}
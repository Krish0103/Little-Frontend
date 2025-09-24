package com.swiggaa.frontend.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.swiggaa.frontend.model.Cart;
import com.swiggaa.frontend.model.MenuItem;
import com.swiggaa.frontend.service.MenuService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @GetMapping
    public String viewMenu(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            // Add timeout and better error handling for menu service call
            Map<String, Object> response = menuService.getAllMenuItems()
                .timeout(java.time.Duration.ofSeconds(10))  // 10 second timeout
                .block();
                
            if (response != null && Boolean.TRUE.equals(response.get("success"))) {
                model.addAttribute("menuItems", response.get("data"));
                model.addAttribute("info", "Menu loaded successfully from service!");
            } else {
                // If menu service fails, show empty menu with message
                model.addAttribute("menuItems", java.util.Collections.emptyList());
                String errorMsg = response != null ? (String) response.get("message") : "Unknown error";
                model.addAttribute("info", "Menu service responded but no items found: " + errorMsg);
            }
        } catch (Exception e) {
            // Fallback: show empty menu instead of crashing
            model.addAttribute("menuItems", java.util.Collections.emptyList());
            model.addAttribute("info", "Unable to connect to menu service: " + e.getMessage() + 
                                    " (Make sure menu-service is running on port 8082)");
        }

        // Add user info to the model for display
        model.addAttribute("username", session.getAttribute("user"));
        model.addAttribute("role", session.getAttribute("role"));

        return "menu/menu";
    }

    @GetMapping("/item/{id}")
    public String menuItemDetails(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = menuService.getMenuItemById(id).block();

            if (response != null && Boolean.TRUE.equals(response.get("success"))) {
                model.addAttribute("menuItem", response.get("data"));
                return "menu/item-details";
            } else {
                model.addAttribute("error", "Menu item not found");
                return "redirect:/menu";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load menu item details");
            return "redirect:/menu";
        }
    }

    @PostMapping("/add-to-cart")
    @ResponseBody
    public String addToCart(@RequestParam(required = false) String menuItemId,
                           @RequestParam(defaultValue = "1") int quantity,
                           HttpSession session) {
        
        System.out.println("DEBUG: Received menuItemId: " + menuItemId);
        System.out.println("DEBUG: Received quantity: " + quantity);
        System.out.println("DEBUG: Session ID: " + session.getId());
        System.out.println("DEBUG: Session attributes:");
        session.getAttributeNames().asIterator().forEachRemaining(attr -> {
            System.out.println("  " + attr + ": " + session.getAttribute(attr));
        });
        
        // Debug session contents
        System.out.println("DEBUG: Session user: " + session.getAttribute("user"));
        
        if (session.getAttribute("user") == null) {
            System.out.println("DEBUG: User not found in session, returning unauthorized");
            return "unauthorized";
        }
        
        if (menuItemId == null || menuItemId.trim().isEmpty()) {
            System.out.println("DEBUG: menuItemId is null or empty");
            return "error";
        }
        
        Long itemId;
        try {
            itemId = Long.parseLong(menuItemId);
        } catch (NumberFormatException e) {
            System.out.println("DEBUG: Invalid menuItemId format: " + menuItemId);
            return "error";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        try {
            System.out.println("DEBUG: About to call menuService.getMenuItemById(" + itemId + ")");
            Map<String, Object> response = menuService.getMenuItemById(itemId).block();
            System.out.println("DEBUG: MenuService response: " + response);

            if (response != null && Boolean.TRUE.equals(response.get("success"))) {
                System.out.println("DEBUG: MenuService response indicates success");
                @SuppressWarnings("unchecked")
                Map<String, Object> itemData = (Map<String, Object>) response.get("data");
                System.out.println("DEBUG: Item data: " + itemData);
                if (itemData != null) {
                    MenuItem menuItem = new MenuItem();
                    menuItem.setId(((Number) itemData.get("id")).longValue());
                    menuItem.setName((String) itemData.get("name"));
                    menuItem.setDescription((String) itemData.get("description"));
                    menuItem.setPrice(new java.math.BigDecimal(itemData.get("price").toString()));
                    menuItem.setCategory((String) itemData.get("category"));
                    menuItem.setImageUrl((String) itemData.get("imageUrl"));
                    menuItem.setAvailable((Boolean) itemData.getOrDefault("available", true));
                    
                    cart.addItem(menuItem, quantity);
                    session.setAttribute("cart", cart);
                    System.out.println("DEBUG: Successfully added item to cart: " + menuItem.getName());
                    return "success";
                } else {
                    System.out.println("DEBUG: Item data is null in response");
                    return "error";
                }
            } else {
                System.out.println("DEBUG: Menu service response failed or null");
                System.out.println("DEBUG: Response object: " + response);
                if (response != null) {
                    System.out.println("DEBUG: Response success value: " + response.get("success"));
                    System.out.println("DEBUG: Response message: " + response.get("message"));
                }
                return "error";
            }
        } catch (Exception e) {
            // Handle error gracefully
            System.err.println("Error adding item to cart: " + e.getMessage());
            e.printStackTrace();
        }

        return "error";
    }

    @GetMapping("/restaurant/{restaurantId}")
    public String viewRestaurantMenu(@PathVariable Long restaurantId, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = menuService.getMenuItemsByRestaurant(restaurantId).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("menuItems", response.get("data"));
                model.addAttribute("restaurantId", restaurantId);
            } else {
                model.addAttribute("error", "Failed to load restaurant menu");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load restaurant menu");
        }

        return "menu/restaurant";
    }

    @GetMapping("/category/{category}")
    public String viewMenuByCategory(@PathVariable String category, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = menuService.getMenuItemsByCategory(category).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("menuItems", response.get("data"));
                model.addAttribute("category", category);
            } else {
                model.addAttribute("error", "Failed to load menu items for category: " + category);
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load menu items for category");
        }

        return "menu/category";
    }

    @GetMapping("/search")
    public String searchMenu(@RequestParam String query, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = menuService.searchMenuItems(query).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("menuItems", response.get("data"));
                model.addAttribute("searchQuery", query);
            } else {
                model.addAttribute("error", "No items found for: " + query);
            }
        } catch (Exception e) {
            model.addAttribute("error", "Search failed");
        }

        return "menu/search";
    }

    @GetMapping("/vegetarian")
    public String viewVegetarianMenu(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = menuService.getVegetarianItems().block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("menuItems", response.get("data"));
                model.addAttribute("filterType", "Vegetarian");
            } else {
                model.addAttribute("error", "Failed to load vegetarian items");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load vegetarian items");
        }

        return "menu/filtered";
    }

    @GetMapping("/vegan")
    public String viewVeganMenu(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = menuService.getVeganItems().block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("menuItems", response.get("data"));
                model.addAttribute("filterType", "Vegan");
            } else {
                model.addAttribute("error", "Failed to load vegan items");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load vegan items");
        }

        return "menu/filtered";
    }
}
package com.swiggaa.frontend.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swiggaa.frontend.model.Cart;
import com.swiggaa.frontend.model.MenuItem;
import com.swiggaa.frontend.service.MenuService;
import com.swiggaa.frontend.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {
    
    @Autowired
    private MenuService menuService;
    
    @Autowired
    private UserService userService;
    
    @GetMapping
    public String viewCart(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        model.addAttribute("cart", cart);
        model.addAttribute("totalAmount", cart.getTotalAmount());
        return "cart/view";
    }
    
    @PostMapping("/add")
    public String addToCartForm(@RequestParam Long menuItemId,
                               @RequestParam int quantity,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        try {
            Map<String, Object> response = menuService.getMenuItemById(menuItemId).block();
            
            if (response != null && (Boolean) response.get("success")) {
                @SuppressWarnings("unchecked")
                Map<String, Object> itemData = (Map<String, Object>) response.get("data");
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
                    redirectAttributes.addFlashAttribute("success", "Item added to cart successfully!");
                } else {
                    redirectAttributes.addFlashAttribute("error", "Menu item not found");
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to add item to cart");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred while adding item to cart");
        }
        
        return "redirect:/cart";
    }
    
    @PostMapping("/add-ajax")
    @ResponseBody
    public String addToCartAjax(@RequestParam Long menuItemId,
                               @RequestParam int quantity,
                               HttpSession session) {
        
        if (session.getAttribute("user") == null) {
            return "unauthorized";
        }
        
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        try {
            Map<String, Object> response = menuService.getMenuItemById(menuItemId).block();
            
            if (response != null && (Boolean) response.get("success")) {
                @SuppressWarnings("unchecked")
                Map<String, Object> itemData = (Map<String, Object>) response.get("data");
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
                    return "success";
                } else {
                    return "error";
                }
            } else {
                return "error";
            }
        } catch (Exception e) {
            return "error";
        }
    }
    
    @PostMapping("/update")
    public String updateCartItem(@RequestParam Long menuItemId,
                                @RequestParam int quantity,
                                HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.updateItemQuantity(menuItemId, quantity);
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart";
    }
    
    @PostMapping("/remove")
    public String removeCartItem(@RequestParam Long menuItemId, HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.removeItem(menuItemId);
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart";
    }
    
    @PostMapping("/clear")
    public String clearCart(HttpSession session) {
        Cart cart = new Cart();
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }
    
    @GetMapping("/checkout")
    public String checkout(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            return "redirect:/cart";
        }

        String username = (String) session.getAttribute("user");
        
        // Fetch user profile data
        Map<String, Object> userResponse = userService.getUserProfile(username).block();
        
        model.addAttribute("cart", cart);
        model.addAttribute("totalAmount", cart.getTotalAmount());
        
        // Add user data to model for pre-populating form
        if (userResponse != null && Boolean.TRUE.equals(userResponse.get("success"))) {
            model.addAttribute("userPhone", userResponse.get("phone"));
            model.addAttribute("userAddress", userResponse.get("address"));
            model.addAttribute("userEmail", userResponse.get("email"));
        }
        
        return "cart/checkout";
    }
}
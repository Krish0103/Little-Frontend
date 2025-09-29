package com.swiggaa.frontend.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swiggaa.frontend.model.Cart;
import com.swiggaa.frontend.model.CartItem;
import com.swiggaa.frontend.service.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public String viewOrders(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        String username = (String) session.getAttribute("user");
        try {
            Map<String, Object> response = orderService.getOrdersByCustomer(username, session).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("orders", response.get("data"));
            } else {
                String errorMessage = response != null && response.get("message") != null 
                    ? (String) response.get("message") 
                    : "Failed to load orders. Please try again later.";
                model.addAttribute("error", errorMessage);
            }
        } catch (Exception e) {
            System.err.println("Exception in viewOrders: " + e.getMessage());
            model.addAttribute("error", "Service temporarily unavailable. Please try again later.");
        }

        return "orders/list";
    }

    @GetMapping("/{id}")
    public String viewOrderDetails(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = orderService.getOrderById(id, session).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("order", response.get("data"));
            } else {
                String errorMessage = response != null && response.get("message") != null 
                    ? (String) response.get("message") 
                    : "Order not found or service unavailable";
                model.addAttribute("error", errorMessage);
                return "redirect:/orders";
            }
        } catch (Exception e) {
            System.err.println("Exception in viewOrderDetails: " + e.getMessage());
            model.addAttribute("error", "Service temporarily unavailable. Please try again later.");
            return "redirect:/orders";
        }

        return "orders/details";
    }

    @PostMapping("/place")
    public String placeOrder(@RequestParam String deliveryAddress,
                           @RequestParam String phoneNumber,
                           @RequestParam String paymentMethod,
                           @RequestParam(required = false) String specialInstructions,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Your cart is empty");
            return "redirect:/cart";
        }

        String username = (String) session.getAttribute("user");
        
        try {
            // Create OrderRequest that matches backend DTO structure
            Map<String, Object> orderRequest = new HashMap<>();
            orderRequest.put("customerUsername", username);
            orderRequest.put("restaurantId", 1L); // Default restaurant for now
            orderRequest.put("restaurantName", "Swiggaa Restaurant");
            orderRequest.put("deliveryAddress", deliveryAddress);
            orderRequest.put("phoneNumber", phoneNumber);
            orderRequest.put("paymentMethod", paymentMethod);
            orderRequest.put("specialInstructions", specialInstructions);
            
            // Convert cart items to order items format expected by backend
            List<Map<String, Object>> orderItems = new ArrayList<>();
            for (CartItem cartItem : cart.getItems()) {
                Map<String, Object> orderItem = new HashMap<>();
                orderItem.put("menuItemId", cartItem.getMenuItemId());
                orderItem.put("itemName", cartItem.getMenuItemName());
                orderItem.put("itemPrice", cartItem.getPrice());
                orderItem.put("quantity", cartItem.getQuantity());
                orderItems.add(orderItem);
            }
            orderRequest.put("orderItems", orderItems);
            
            Map<String, Object> response = orderService.createOrderRequest(orderRequest, session).block();
            
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                // Clear cart after successful order
                session.setAttribute("cart", new Cart());
                
                Map<String, Object> orderData = (Map<String, Object>) response.get("data");
                Long orderId = ((Number) orderData.get("id")).longValue();
                
                // Redirect to confirmation page instead of order details
                return "redirect:/orders/confirmation/" + orderId;
            } else {
                String errorMessage = "Failed to place order";
                if (response != null && response.get("message") != null) {
                    errorMessage = (String) response.get("message");
                }
                if (redirectAttributes != null) {
                    redirectAttributes.addFlashAttribute("error", errorMessage);
                }
                return "redirect:/cart/checkout";
            }
        } catch (Exception e) {
            if (redirectAttributes != null) {
                redirectAttributes.addFlashAttribute("error", "Failed to place order. Please try again.");
            }
            return "redirect:/cart/checkout";
        }
    }

    @PostMapping("/{id}/cancel")
    public String cancelOrder(@PathVariable Long id, 
                            HttpSession session, 
                            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = orderService.cancelOrder(id, session).block();
            
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                redirectAttributes.addFlashAttribute("success", "Order cancelled successfully");
            } else {
                String errorMessage = "Failed to cancel order";
                if (response != null && response.get("message") != null) {
                    errorMessage = (String) response.get("message");
                }
                if (redirectAttributes != null) {
                    redirectAttributes.addFlashAttribute("error", errorMessage);
                }
            }
        } catch (Exception e) {
            if (redirectAttributes != null) {
                redirectAttributes.addFlashAttribute("error", "Failed to cancel order");
            }
        }

        return "redirect:/orders/" + id;
    }

        @GetMapping("/track/{id}")
    public String trackOrder(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = orderService.getOrderById(id, session).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("order", response.get("data"));
            } else {
                model.addAttribute("error", "Order not found");
                return "redirect:/orders";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load order tracking");
            return "redirect:/orders";
        }

        return "orders/tracking";
    }
    
    @GetMapping("/confirmation/{id}")
    public String orderConfirmation(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Map<String, Object> response = orderService.getOrderById(id, session).block();
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                model.addAttribute("order", response.get("data"));
                model.addAttribute("success", "Order placed successfully!");
            } else {
                model.addAttribute("error", "Order not found");
                return "redirect:/orders";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load order details");
            return "redirect:/orders";
        }

        return "orders/order-confirmation";
    }
}
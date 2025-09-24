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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.swiggaa.frontend.model.Cart;
import com.swiggaa.frontend.model.Order;
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
                model.addAttribute("error", "Failed to load orders");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load orders");
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
                model.addAttribute("error", "Order not found");
                return "redirect:/orders";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load order details");
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
            Order order = new Order();
            order.setCustomerUsername(username);
            order.setDeliveryAddress(deliveryAddress);
            order.setPhoneNumber(phoneNumber);
            order.setPaymentMethod(paymentMethod);
            order.setSpecialInstructions(specialInstructions);
            
            // Convert cart to order items
            order.setOrderItems(cart.convertToOrderItems());
            order.setTotalAmount(cart.getTotalAmount());
            
            Map<String, Object> response = orderService.createOrder(order, session).block();
            
            if (response != null && (Boolean) response.getOrDefault("success", true)) {
                // Clear cart after successful order
                session.setAttribute("cart", new Cart());
                redirectAttributes.addFlashAttribute("success", "Order placed successfully!");
                
                Map<String, Object> orderData = (Map<String, Object>) response.get("data");
                Long orderId = ((Number) orderData.get("id")).longValue();
                
                return "redirect:/orders/" + orderId;
            } else {
                redirectAttributes.addFlashAttribute("error", response.get("message"));
                return "redirect:/cart/checkout";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to place order. Please try again.");
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
                redirectAttributes.addFlashAttribute("error", response.get("message"));
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel order");
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
            model.addAttribute("error", "Unable to track order");
            return "redirect:/orders";
        }

        return "orders/track";
    }
}
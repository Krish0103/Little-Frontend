package com.swiggaa.frontend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import java.util.HashMap;
import java.util.Map;

@Service
public class MenuService {

    @Autowired
    @Qualifier("menuServiceWebClient")
    private WebClient menuWebClient;
    
    private final ParameterizedTypeReference<Map<String, Object>> mapType = 
        new ParameterizedTypeReference<Map<String, Object>>() {};

    public Mono<Map<String, Object>> getAllMenuItems() {
        return menuWebClient.get()
                .uri("/menu/items")
                .header("Accept", "application/json")
                .retrieve()
                .bodyToMono(mapType)
                .map(response -> {
                    Map<String, Object> result = new HashMap<>();
                    if (response.get("success") != null && (Boolean) response.get("success")) {
                        result.put("success", true);
                        result.put("data", response.get("data"));
                        result.put("message", response.get("message"));
                    } else {
                        result.put("success", false);
                        result.put("message", response.get("message"));
                    }
                    return result;
                })
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch menu items"));
    }

    public Mono<Map<String, Object>> getMenuItemsByRestaurant(Long restaurantId) {
        return menuWebClient.get()
                .uri("/menu/restaurant/{restaurantId}", restaurantId)
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch restaurant menu"));
    }

    public Mono<Map<String, Object>> getMenuItemsByCategory(String category) {
        return menuWebClient.get()
                .uri("/menu/category/{category}", category)
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch menu by category"));
    }

    public Mono<Map<String, Object>> searchMenuItems(String name) {
        return menuWebClient.get()
                .uri("/menu/search?name={name}", name)
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Search failed"));
    }

    public Mono<Map<String, Object>> getMenuItemById(Long id) {
        return menuWebClient.get()
                .uri("/menu/items/{id}", id)
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Menu item not found"));
    }

    public Mono<Map<String, Object>> getVegetarianItems() {
        return menuWebClient.get()
                .uri("/menu/vegetarian")
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch vegetarian items"));
    }

    public Mono<Map<String, Object>> getVeganItems() {
        return menuWebClient.get()
                .uri("/menu/vegan")
                .retrieve()
                .bodyToMono(mapType)
                .onErrorReturn(Map.of("success", false, "message", "Failed to fetch vegan items"));
    }
}
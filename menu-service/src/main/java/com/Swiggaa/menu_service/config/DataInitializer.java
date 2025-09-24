package com.Swiggaa.menu_service.config;

import com.Swiggaa.menu_service.model.MenuItem;
import com.Swiggaa.menu_service.repository.MenuItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private MenuItemRepository menuItemRepository;

    @Override
    public void run(String... args) throws Exception {
        if (menuItemRepository.count() == 0) {
            createSampleMenuItems();
        }
    }

    private void createSampleMenuItems() {
        // Create sample menu items
        MenuItem pizza = new MenuItem();
        pizza.setName("Margherita Pizza");
        pizza.setDescription("Fresh tomatoes, mozzarella cheese, fresh sweet basil, salt and extra-virgin olive oil");
        pizza.setPrice(new BigDecimal("12.99"));
        pizza.setCategory("Pizza");
        pizza.setRestaurantId(1L);
        pizza.setRestaurantName("Mario's Italian Kitchen");
        pizza.setAvailable(true);
        pizza.setImageUrl("https://via.placeholder.com/300x200?text=Margherita+Pizza");
        pizza.setVegetarian(true);
        pizza.setVegan(false);
        pizza.setGlutenFree(false);
        pizza.setPreparationTime(25);
        menuItemRepository.save(pizza);

        MenuItem burger = new MenuItem();
        burger.setName("Classic Cheeseburger");
        burger.setDescription("Juicy beef patty with cheddar cheese, lettuce, tomato, onion, and special sauce");
        burger.setPrice(new BigDecimal("9.99"));
        burger.setCategory("Burger");
        burger.setRestaurantId(2L);
        burger.setRestaurantName("Burger Paradise");
        burger.setAvailable(true);
        burger.setImageUrl("https://via.placeholder.com/300x200?text=Cheeseburger");
        burger.setVegetarian(false);
        burger.setVegan(false);
        burger.setGlutenFree(false);
        burger.setPreparationTime(15);
        menuItemRepository.save(burger);

        MenuItem curry = new MenuItem();
        curry.setName("Chicken Tikka Masala");
        curry.setDescription("Tender chicken pieces in creamy tomato-based curry sauce with aromatic spices");
        curry.setPrice(new BigDecimal("14.99"));
        curry.setCategory("Indian");
        curry.setRestaurantId(3L);
        curry.setRestaurantName("Spice Garden");
        curry.setAvailable(true);
        curry.setImageUrl("https://via.placeholder.com/300x200?text=Tikka+Masala");
        curry.setVegetarian(false);
        curry.setVegan(false);
        curry.setGlutenFree(true);
        curry.setPreparationTime(30);
        menuItemRepository.save(curry);

        MenuItem salad = new MenuItem();
        salad.setName("Mediterranean Quinoa Salad");
        salad.setDescription("Fresh quinoa with cucumber, tomatoes, olives, feta cheese, and lemon vinaigrette");
        salad.setPrice(new BigDecimal("11.99"));
        salad.setCategory("Salad");
        salad.setRestaurantId(4L);
        salad.setRestaurantName("Green Garden Cafe");
        salad.setAvailable(true);
        salad.setImageUrl("https://via.placeholder.com/300x200?text=Quinoa+Salad");
        salad.setVegetarian(true);
        salad.setVegan(false);
        salad.setGlutenFree(true);
        salad.setPreparationTime(10);
        menuItemRepository.save(salad);

        MenuItem noodles = new MenuItem();
        noodles.setName("Pad Thai Noodles");
        noodles.setDescription("Stir-fried rice noodles with tofu, bean sprouts, eggs, and tamarind sauce");
        noodles.setPrice(new BigDecimal("13.99"));
        noodles.setCategory("Chinese");
        noodles.setRestaurantId(5L);
        noodles.setRestaurantName("Golden Dragon");
        noodles.setAvailable(true);
        noodles.setImageUrl("https://via.placeholder.com/300x200?text=Pad+Thai");
        noodles.setVegetarian(true);
        noodles.setVegan(true);
        noodles.setGlutenFree(false);
        noodles.setPreparationTime(20);
        menuItemRepository.save(noodles);

        MenuItem dessert = new MenuItem();
        dessert.setName("Chocolate Lava Cake");
        dessert.setDescription("Warm chocolate cake with molten chocolate center, served with vanilla ice cream");
        dessert.setPrice(new BigDecimal("7.99"));
        dessert.setCategory("Dessert");
        dessert.setRestaurantId(6L);
        dessert.setRestaurantName("Sweet Dreams Bakery");
        dessert.setAvailable(true);
        dessert.setImageUrl("https://via.placeholder.com/300x200?text=Lava+Cake");
        dessert.setVegetarian(true);
        dessert.setVegan(false);
        dessert.setGlutenFree(false);
        dessert.setPreparationTime(12);
        menuItemRepository.save(dessert);

        System.out.println("Sample menu items created successfully!");
    }
}
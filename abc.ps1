# ====================================================================
# EDITABLE MENU UPDATE SCRIPT
# ====================================================================
# Instructions: 
# 1. Edit the details below for each menu item as needed
# 2. Save the file
# 3. Let me know when you're ready to run it
# ====================================================================

Write-Host "🍽 UPDATING ALL MENU ITEMS..." -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Green

# ====================================================================
# ITEM 1: MARGHERITA PIZZA
# ====================================================================
$item1 = @{
    name = "Margherita Pizza"
    description = "Fresh tomatoes, mozzarella cheese, fresh sweet basil, salt and extra-virgin olive oil"
    price = 249.00
    category = "Pizza"
    restaurantId = 1
    restaurantName = "Mario's Italian Kitchen"
    available = $true
    imageUrl = "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=300&h=200&fit=crop&auto=format"
    vegetarian = $true
    vegan = $false
    glutenFree = $false
    preparationTime = 25
} | ConvertTo-Json

Write-Host "Updating Item 1: Margherita Pizza..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:8082/menu/items/1" -Method PUT -Body $item1 -ContentType "application/json"

# ====================================================================
# ITEM 2: VEGGIE DELUXE BURGER
# ====================================================================
$item2 = @{
    name = "Veggie Deluxe Burger"
    description = "Delicious plant-based patty with fresh vegetables, cheese, lettuce, tomato, onion, and special herb sauce"
    price = 150.00
    category = "Burger"
    restaurantId = 2
    restaurantName = "Burger Paradise"
    available = $true
    imageUrl = "https://images.unsplash.com/photo-1520073201527-6b044ba2ca9f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8VmVnJTIwYnVyZ2VyfGVufDB8fDB8fHww"
    vegetarian = $true
    vegan = $false
    glutenFree = $false
    preparationTime = 15
} | ConvertTo-Json

Write-Host "Updating Item 2: Veggie Deluxe Burger..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:8082/menu/items/2" -Method PUT -Body $item2 -ContentType "application/json"

# ====================================================================
# ITEM 3: PANEER TIKKA MASALA
# ====================================================================
$item3 = @{
    name = "Paneer Tikka Masala"
    description = "Soft cottage cheese cubes in rich creamy tomato-based curry sauce with aromatic Indian spices"
    price = 349.00
    category = "Indian"
    restaurantId = 3
    restaurantName = "Spice Garden"
    available = $true
    imageUrl = "https://images.unsplash.com/photo-1596797038530-2c107229654b?w=300&h=200&fit=crop&auto=format"
    vegetarian = $true
    vegan = $false
    glutenFree = $true
    preparationTime = 25
} | ConvertTo-Json

Write-Host "Updating Item 3: Paneer Tikka Masala..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:8082/menu/items/3" -Method PUT -Body $item3 -ContentType "application/json"

# ====================================================================
# ITEM 4: MEDITERRANEAN QUINOA SALAD
# ====================================================================
$item4 = @{
    name = "Mediterranean Quinoa Salad"
    description = "Fresh quinoa with cucumber, tomatoes, olives, feta cheese, and lemon vinaigrette"
    price = 229
    category = "Salad"
    restaurantId = 4
    restaurantName = "Green Garden Cafe"
    available = $true
    imageUrl = "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300&h=200&fit=crop&auto=format"
    vegetarian = $true
    vegan = $false
    glutenFree = $true
    preparationTime = 10
} | ConvertTo-Json

Write-Host "Updating Item 4: Mediterranean Quinoa Salad..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:8082/menu/items/4" -Method PUT -Body $item4 -ContentType "application/json"

# ====================================================================
# ITEM 5: VEGETARIAN PAD THAI
# ====================================================================
$item5 = @{
    name = "Vegetarian Pad Thai"
    description = "Stir-fried rice noodles with tofu, fresh vegetables, bean sprouts, and tangy tamarind sauce"
    price = 499
    category = "Chinese"
    restaurantId = 5
    restaurantName = "Golden Dragon"
    available = $true
    imageUrl = "https://plus.unsplash.com/premium_photo-1664472637341-3ec829d1f4df?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGFkJTIwdGhhaXxlbnwwfHwwfHx8MA%3D%3D"
    vegetarian = $true
    vegan = $true
    glutenFree = $false
    preparationTime = 20
} | ConvertTo-Json

Write-Host "Updating Item 5: Vegetarian Pad Thai..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:8082/menu/items/5" -Method PUT -Body $item5 -ContentType "application/json"

# ====================================================================
# ITEM 6: CHOCOLATE LAVA CAKE
# ====================================================================
$item6 = @{
    name = "Chocolate Lava Cake"
    description = "Warm chocolate cake with molten chocolate center, served with vanilla ice cream"
    price = 149
    category = "Dessert"
    restaurantId = 6
    restaurantName = "Sweet Dreams Bakery"
    available = $true
    imageUrl = "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=300&h=200&fit=crop&auto=format"
    vegetarian = $true
    vegan = $false
    glutenFree = $false
    preparationTime = 12
} | ConvertTo-Json

Write-Host "Updating Item 6: Chocolate Lava Cake..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:8082/menu/items/6" -Method PUT -Body $item6 -ContentType "application/json"

# ====================================================================
# COMPLETION MESSAGE
# ====================================================================
Write-Host "`n✅ ALL MENU ITEMS UPDATED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "🌱 All items remain 100% Pure Vegetarian!" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Green

# ====================================================================
# FIELD GUIDE FOR EDITING:
# ====================================================================
<#
EDITABLE FIELDS FOR EACH ITEM:
- name: The display name of the dish
- description: Detailed description of the dish
- price: Price (use decimal format like 12.99)
- category: Category (Pizza, Burger, Indian, Salad, Chinese, Dessert)
- restaurantId: Restaurant ID number (1-6)
- restaurantName: Name of the restaurant
- available: true/false (item availability)
- imageUrl: Full URL to the food image
- vegetarian: true/false (keep true for vegetarian menu)
- vegan: true/false (completely plant-based)
- glutenFree: true/false (gluten-free option)
- preparationTime: Time in minutes to prepare

EXAMPLE CHANGES YOU CAN MAKE:
- Update prices
- Change descriptions
- Add new image URLs
- Modify preparation times
- Change restaurant names
- Update categories
- Toggle availability
#>
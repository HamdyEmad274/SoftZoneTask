using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OnlineRestaurantService.Context;
using OnlineRestaurantService.Models;
using OnlineRestaurantService.DTOs;

public class RestaurantsController : ControllerBase
{
    private readonly RestaurantDbContext _context;

    public RestaurantsController(RestaurantDbContext context)
    {
        _context = context;
    }

    // Get all restaurants
    [HttpGet]
    [Route("api/restaurants/GetAll")]
    public async Task<IActionResult> GetRestaurants()
    {
        var restaurants = await _context.Restaurants
                .ToListAsync();

        var restaurantDtos = restaurants.Select(r => new RestaurantDto
        {
            Id = r.Id,
            Name = r.Name,
            ImageUrl = r.ImageUrl,
            Address = r.Address,
            AverageRating = r.AverageRating,
            NumberOfComments = r.NumberOfComments,
            NumberOfLikes = r.NumberOfLikes,
            Description = r.Description,
            
        }).ToList();

        return Ok(restaurantDtos);
    }

    // Get a restaurant by ID
    [HttpGet]
    [Route("api/restaurants/GetBy{id}", Name = "GetRestaurantById")]
    public async Task<IActionResult> GetRestaurantById(int id)
    {
        var restaurant = await _context.Restaurants.
            Include(r => r.MenuItems).
            FirstOrDefaultAsync(r => r.Id == id);
        if (restaurant == null)
        {
            return NotFound($"Restaurant with ID '{id}' not found.");
        }
        var restaurantDto = new RestaurantDto
        {
            Id = restaurant.Id,
            Name = restaurant.Name,
            ImageUrl = restaurant.ImageUrl,
            Address = restaurant.Address,
            AverageRating = restaurant.AverageRating,
            NumberOfComments = restaurant.NumberOfComments,
            NumberOfLikes = restaurant.NumberOfLikes,
            Description = restaurant.Description,
            MenuItems = restaurant.MenuItems.Select(mi => new MenuItemDto
            {
                Id = mi.Id,
                Name = mi.Name,
                Description = mi.Description,
                Price = mi.Price
            }).ToList()
        };
        return Ok(restaurantDto);
    }
    // Get a restaurant by name
    // Get a restaurant by name
    // Get a restaurant by name (search by name containing the input string)
    [HttpGet]
    [Route("api/restaurants/GetByName/{name}")]
    public async Task<IActionResult> GetRestaurantByName(string name)
    {
        var restaurants = await _context.Restaurants
            .Include(r => r.MenuItems)
            .Where(r => r.Name.Contains(name))
            .ToListAsync();

        if (restaurants == null || !restaurants.Any())
        {
            return NotFound($"No restaurants found with name containing '{name}'.");
        }

        var restaurantDtos = restaurants.Select(restaurant => new RestaurantDto
        {
            Id = restaurant.Id,
            Name = restaurant.Name,
            ImageUrl = restaurant.ImageUrl,
            Address = restaurant.Address,
            AverageRating = restaurant.AverageRating,
            NumberOfComments = restaurant.NumberOfComments,
            NumberOfLikes = restaurant.NumberOfLikes,
            Description = restaurant.Description,
            MenuItems = restaurant.MenuItems.Select(mi => new MenuItemDto
            {
                Id = mi.Id,
                Name = mi.Name,
                Description = mi.Description,
                Price = mi.Price
            }).ToList()
        }).ToList();

        return Ok(restaurantDtos);
    }
    [HttpGet]
    [Route("api/restaurants/GetByNameAndCity")]
    public async Task<IActionResult> GetRestaurantsByNameAndCity(string? name, string? city)
    {
        IQueryable<Restaurant> query = _context.Restaurants.Include(r => r.MenuItems);

        if (!string.IsNullOrEmpty(name))
        {
            // Filter by restaurant name
            query = query.Where(r => r.Name.Contains(name));
        }

        if (!string.IsNullOrEmpty(city))
        {
            // Filter by city
            query = query.Where(r => r.Address.Contains(city));
        }

        var restaurants = await query.ToListAsync();

        if (restaurants == null || !restaurants.Any())
        {
            return NotFound($"No restaurants found.");
        }

        var restaurantDtos = restaurants.Select(r => new RestaurantDto
        {
            Id = r.Id,
            Name = r.Name,
            ImageUrl = r.ImageUrl,
            Address = r.Address,
            AverageRating = r.AverageRating,
            NumberOfComments = r.NumberOfComments,
            NumberOfLikes = r.NumberOfLikes,
            Description = r.Description,
            MenuItems = r.MenuItems.Select(mi => new MenuItemDto
            {
                Id = mi.Id,
                Name = mi.Name,
                Description = mi.Description,
                Price = mi.Price
            }).ToList()
        }).ToList();

        return Ok(restaurantDtos);
    }


    // Create a new restaurant
    [HttpPost]
    [Route("api/restaurants/Create")]
    public async Task<IActionResult> CreateRestaurant([FromBody] CreateRestaurantDto restaurantDto)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        var restaurant = new Restaurant
        {
            Name = restaurantDto.Name,
            ImageUrl = restaurantDto.ImageUrl,
            Address = restaurantDto.Address,
            Description = restaurantDto.Description
        };
        _context.Restaurants.Add(restaurant);
        await _context.SaveChangesAsync();
        var response = new
        {
            Message = "Restaurant created successfully",
            Restaurant = new RestaurantDto
            {
                Id = restaurant.Id,
                Name = restaurant.Name,
                ImageUrl = restaurant.ImageUrl,
                Address = restaurant.Address,
                AverageRating = restaurant.AverageRating,
                NumberOfComments = restaurant.NumberOfComments,
                NumberOfLikes = restaurant.NumberOfLikes,
                Description = restaurant.Description
            }
        };
        var result = CreatedAtAction(nameof(GetRestaurantById), new { id = restaurant.Id }, response);
        return result;
    }
    // Update a restaurant by ID
    [HttpPut]
    [Route("api/restaurants/Update{id}", Name = "UpdateRestaurant")]
    public async Task<IActionResult> UpdateRestaurant(int id, [FromBody] Restaurant restaurant)
    {
        if (id != restaurant.Id)
        {
            return BadRequest();
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var existingRestaurant = await _context.Restaurants.FindAsync(id);
        if (existingRestaurant == null)
        {
            return NotFound();
        }

        // Update relevant properties of existingRestaurant object here (e.g., using reflection or a mapping library)
        existingRestaurant.Name = restaurant.Name;
        // Update other properties as needed

        _context.Restaurants.Update(existingRestaurant);
        await _context.SaveChangesAsync();

        return Ok(new { Message = "Restaurant updated successfully" }); // Successful update with Message
    }
    // Delete a restaurant by ID
    [HttpDelete]
    [Route("api/restaurants/Delete{id}", Name = "DeleteRestaurant")]
    public async Task<IActionResult> DeleteRestaurant(int id)
    {
        var restaurant = await _context.Restaurants.FindAsync(id);
        if (restaurant == null)
        {
            return NotFound();
        }

        _context.Restaurants.Remove(restaurant);
        await _context.SaveChangesAsync();

        return NoContent(); // Successful deletion with no content returned
    }
    [HttpGet]
    [Route("api/restaurants/GetByCity/{city}")]
    public async Task<IActionResult> GetRestaurantsByCity(string city)
    {
        // Query the database to retrieve restaurants based on the provided city
        var restaurants = await _context.Restaurants
            .Where(r => r.Address.Contains(city))
            .ToListAsync();

        // Check if any restaurants were found
        if (restaurants == null || !restaurants.Any())
        {
            return NotFound($"No restaurants found in the city '{city}'.");
        }

        return Ok(restaurants);
    }
    // Get menu items for a restaurant by ID
    [HttpGet]
    [Route("api/restaurants/{restaurantId}/menu")]
    public async Task<IActionResult> GetMenuItemsForRestaurant(int restaurantId)
    {
        // Retrieve the restaurant from the database including its menu items
        var restaurant = await _context.Restaurants
            .Include(r => r.MenuItems) // Include menu items in the query
            .FirstOrDefaultAsync(r => r.Id == restaurantId);

        // Check if the restaurant exists
        if (restaurant == null)
        {
            return NotFound($"Restaurant with ID {restaurantId} not found.");
        }

        // Convert menu items to DTOs
        var menuItemsDto = restaurant.MenuItems.Select(mi => new MenuItemDto
        {
            Id = mi.Id,
            Name = mi.Name,
            Description = mi.Description,
            Price = mi.Price
        }).ToList();

        return Ok(menuItemsDto);
    }
    // Create a new menu item for a restaurant by ID
    [HttpPost]
    [Route("api/restaurants/{restaurantId}/menu")]
    public async Task<IActionResult> CreateMenuItemForRestaurant(int restaurantId, [FromBody] MenuItemDto menuItemDto)
    {
        // Retrieve the restaurant from the database
        var restaurant = await _context.Restaurants.FindAsync(restaurantId);

        // Check if the restaurant exists
        if (restaurant == null)
        {
            return NotFound($"Restaurant with ID {restaurantId} not found.");
        }

        // Create a new MenuItem entity from the DTO
        var menuItem = new MenuItem
        {
            Name = menuItemDto.Name,
            Description = menuItemDto.Description,
            Price = menuItemDto.Price,
            Restaurant = restaurant // Associate with the specified restaurant
        };

        // Add the new menu item to the database
        _context.MenuItems.Add(menuItem);
        await _context.SaveChangesAsync();

        // Convert the created menu item to a DTO
        var createdMenuItemDto = new MenuItemDto
        {
            Id = menuItem.Id,
            Name = menuItem.Name,
            Description = menuItem.Description,
            Price = menuItem.Price
        };

        // Return a success response with the created menu item DTO
        return CreatedAtAction(nameof(GetMenuItemsForRestaurant), new { restaurantId }, createdMenuItemDto);
    }
}
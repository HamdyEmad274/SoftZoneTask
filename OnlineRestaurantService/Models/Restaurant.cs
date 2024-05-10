namespace OnlineRestaurantService.Models
{
    public class Restaurant
    {
        public int Id { get; set; } // Primary key for the restaurant in the database (auto-incrementing)
        public string Name { get; set; } // Name of the restaurant
        public string ImageUrl { get; set; } // URL of the restaurant's image (stored on a web server)
        public string Address { get; set; } // Physical address of the restaurant
        public decimal AverageRating { get; set; } // Average customer rating for the restaurant (optional)
        public int NumberOfComments { get; set; } // Number of comments left by customers (optional)
        public int NumberOfLikes { get; set; } // Number of likes received by the restaurant (optional)
        public string Description { get; set; } // Short description of the restaurant (optional)
        public ICollection<MenuItem> MenuItems { get; set; } // Collection of menu items for the restaurant (optional>
    }

}

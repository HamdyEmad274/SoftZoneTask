namespace OnlineRestaurantService.DTOs
{
    public class RestaurantDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public string Address { get; set; }
        public decimal AverageRating { get; set; }
        public int NumberOfComments { get; set; }
        public int NumberOfLikes { get; set; }
        public string Description { get; set; }
        public ICollection<MenuItemDto> MenuItems { get; set; } // Include menu items in the DTO

    }
}

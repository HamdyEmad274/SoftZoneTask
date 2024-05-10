using System.ComponentModel.DataAnnotations;
namespace OnlineRestaurantService.DTOs
{
    public class CreateRestaurantDto
    {
        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "ImageUrl is required")]
        [Url(ErrorMessage = "ImageUrl is not valid")]
        public string ImageUrl { get; set; }

        [Required(ErrorMessage = "Address is required")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Description is required")]
        public string Description { get; set; }
    }
}

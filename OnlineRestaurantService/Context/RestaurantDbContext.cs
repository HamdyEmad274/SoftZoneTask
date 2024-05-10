using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using OnlineRestaurantService.Models;

namespace OnlineRestaurantService.Context
{
    public class RestaurantDbContext : DbContext
    {
        public RestaurantDbContext(IConfiguration configuration) : base(GetDbContextOptions(configuration))
        {
        }

        private static DbContextOptions GetDbContextOptions(IConfiguration configuration)
        {
            var optionsBuilder = new DbContextOptionsBuilder<RestaurantDbContext>();
            optionsBuilder.UseSqlServer(configuration.GetConnectionString("DefaultConnection"));
            return optionsBuilder.Options;
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<MenuItem>()
                .Property(m => m.Price)
                .HasColumnType("decimal(18,2)");
            modelBuilder.Entity<Restaurant>()
                .Property(r => r.AverageRating)
                .HasColumnType("decimal(5,2)");
        }
        public DbSet<Restaurant> Restaurants { get; set; }
        public DbSet<MenuItem> MenuItems { get; set; }
    }
}
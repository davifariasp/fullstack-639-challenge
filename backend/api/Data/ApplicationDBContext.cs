using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using api.Models;

namespace api.Data
{
    public class ApplicationDBContext : DbContext
    {
        public ApplicationDBContext (DbContextOptions dbContextOptions)
            : base(dbContextOptions)
        {
        }

        public DbSet<WeatherAlert> WeatherAlerts { get; set; }

        public DbSet<User> Users { get; set; }
    }
}
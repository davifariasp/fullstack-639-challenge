using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Data;
using api.Interfaces;
using api.Models;
using Microsoft.EntityFrameworkCore;

namespace api.Repository
{
    public class WeatherAlertRepository : IWeatherAlert
    {   
        private readonly ApplicationDBContext _context;
        
        public WeatherAlertRepository(ApplicationDBContext context)
        {
            _context = context;
        }

        public async Task<WeatherAlert> CreateAsync(WeatherAlert weatherAlert)
        {
            await _context.WeatherAlerts.AddAsync(weatherAlert);
            await _context.SaveChangesAsync();

            return weatherAlert;
        }

        public Task<List<WeatherAlert>> GetAllAsync()
        {
            return _context.WeatherAlerts.ToListAsync();
        }
    }
}
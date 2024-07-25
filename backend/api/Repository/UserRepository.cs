using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Data;
using api.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using api.Mappers;
using Microsoft.Extensions.Caching.Distributed;
using api.Dtos.User;

namespace api.Interfaces.Repository
{
    public class UserRepository : IUserRepository
    {   
        private readonly ApplicationDBContext _context;
        private readonly IDistributedCache _cache;

        public UserRepository(ApplicationDBContext context, IDistributedCache cache)
        {
            _context = context;
            _cache = cache;
        }

        public async Task<User> CreateAsync(User user)
        {

            await _context.Users.AddAsync(user);
            await _context.SaveChangesAsync();

            return user;
        }

        public async Task<List<User>> GetAllAsync()
        {   
            return await _context.Users.ToListAsync();
        }

        public async Task<User?> GetByIdAsync(int id)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.Id == id);
        }

        public async Task<User?> GetByEmailAsync(string email)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
        }

        //usuarios no redis
        public void setUserOnline(string lat, string lon, string tokenDevice)
        {
            var user = new
            {
                lat,
                lon,
                tokenDevice
            };

            var userJson = System.Text.Json.JsonSerializer.Serialize(user);
            _cache.SetString("device:" + tokenDevice, userJson);
        }

        public List<UserOnlineDto> getUsersOnline()
        {
            List<UserOnlineDto> usersOnline = new List<UserOnlineDto>();

            for (int i = 1; i <= 100; i++) // Supondo que o ID máximo do usuário seja 100
            {
                var json = _cache.GetString("user:" + i);
                if (!string.IsNullOrEmpty(json))
                {
                    UserOnlineDto user = UserOnlineDto.FromJson(json);
                    usersOnline.Add(user);
                }
            }

            return usersOnline;
        }
    }
}
using api.Data;
using api.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Distributed;
using api.Dtos.User;
using System.Text.Json;
using api.Interfaces;

namespace api.Repository
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
        public async Task SetUserOnline(double lat, double lon, string tokenDevice)
        {
            var user = new
            {
                lat,
                lon,
                tokenDevice
            };

            var userJson = System.Text.Json.JsonSerializer.Serialize(user);
            await _cache.SetStringAsync("user:" + tokenDevice, userJson);

            // Adiciona o token ao conjunto de tokens
            var tokens = await _cache.GetStringAsync("userTokens");
            var tokenList = tokens != null ? JsonSerializer.Deserialize<HashSet<string>>(tokens) : new HashSet<string>();
            tokenList!.Add(tokenDevice);

            var updatedTokensJson = JsonSerializer.Serialize(tokenList);
            await _cache.SetStringAsync("userTokens", updatedTokensJson);
        }

        public async Task<List<UserOnlineDto>> GetUsersOnline()
        {
            List<UserOnlineDto> usersOnline = new List<UserOnlineDto>();

            // Obtém todos os tokens do conjunto
            var tokensJson = await _cache.GetStringAsync("userTokens");
            var tokens = tokensJson != null ? JsonSerializer.Deserialize<HashSet<string>>(tokensJson) : new HashSet<string>();

             if (tokens != null){
                foreach (var token in tokens)
            {
                var key = "user:" + token;
                var json = await _cache.GetStringAsync(key);

                if (!string.IsNullOrEmpty(json))
                {   
                    UserOnlineDto user = UserOnlineDto.FromJson(json);
                    usersOnline.Add(user);
                }
            }
             }
            
            return usersOnline;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Dtos.User;
using api.Models;

namespace api.Interfaces
{
    public interface IUserRepository
    {
        Task<List<User>> GetAllAsync();
        Task<User?> GetByIdAsync(int id);

        Task<User> CreateAsync(User user);

        Task<User?> GetByEmailAsync(string email);

        Task SetUserOnline(double lat, double lon, string deviceToken);

        Task RemoveUserOnline(string deviceToken);
        
        Task<List<UserOnlineDto>> GetUsersOnline();
    }
}
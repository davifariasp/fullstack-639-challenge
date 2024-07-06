using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Interfaces
{
    public interface IFirebaseNotificationService
    {
        Task SendNotificationAsync(string token, string title, string body);
    }
}
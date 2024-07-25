using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;

namespace api.Dtos.User
{
    public class UserOnlineDto
    {
        public double? Lat { get; set; }
        public double? Lon { get; set; }

        public string? TokenDevice { get; set; }

        // Opcional: método de fábrica estático para criar UserOnlineDto a partir do JSON
        public static UserOnlineDto FromJson(string json)
        {
            return JsonSerializer.Deserialize<UserOnlineDto>(json)!;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Dtos.User
{
    public class LoginDto
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public double Lat { get; set; }
        public double Lon { get; set; }
        public string TokenDevice { get; set; }
    }
}
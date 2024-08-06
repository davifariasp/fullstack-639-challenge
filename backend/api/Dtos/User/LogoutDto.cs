using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Dtos.User
{
    public class LogoutDto
    {
        public required string TokenDevice { get; set; }
    }
}
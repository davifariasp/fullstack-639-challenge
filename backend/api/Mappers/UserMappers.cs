using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Dtos.User;
using api.Models;

namespace api.Mappers
{
    public static class UserMappers
    {
        public static UserDto ToUserDto(this User userModel)
        {
            return new UserDto
            {
                Id = userModel.Id,
                Name = userModel.Name,
                Email = userModel.Email,
            };
        }

        public static User ToUserFromCreateDTO(this CreateUserRequestDto userDto)
        {   
            Random random = new Random();
            int intRandom = random.Next(100); // Gera um número entre 0 e 99

            return new User
            {
                Id = intRandom,
                Name = userDto.Name,
                Email = userDto.Email,
                Password = userDto.Password
            };
        }
    }
}
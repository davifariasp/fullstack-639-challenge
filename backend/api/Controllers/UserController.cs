using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Data;
using api.Dtos.User;
using api.Interfaces;
using api.Mappers;
using api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace api.Controllers
{
    [Route("api/users")]
    [ApiController]
    public class UserController : ControllerBase
    {   
        private readonly ApplicationDBContext _context;
        private readonly IUserRepository _userRepo;

        public UserController(ApplicationDBContext context, IUserRepository userRepository)
        {   
            _userRepo = userRepository;
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetUsers()
        {   
            var users = await _userRepo.GetAllAsync();
            var usersDto = users.Select(u => u.ToUserDto());

            return Ok(usersDto);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetUser([FromRoute] int id)
        {
            var user = await _userRepo.GetByIdAsync(id);

            if(user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateUserRequestDto userDto)
        {   
            var userModel = userDto.ToUserFromCreateDTO();
            await _userRepo.CreateAsync(userModel);

            return CreatedAtAction(nameof(GetUser), new { id = userModel.Id }, userModel);
        }
    }
}
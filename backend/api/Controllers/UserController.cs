using api.Data;
using api.Dtos.User;
using api.Interfaces;
using api.Mappers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("users")]
    [ApiController]
    public class UserController : ControllerBase
    {   
        private readonly ApplicationDBContext _context;
        private readonly IUserRepository _userRepo;
        private readonly ITokenService _tokenService;

        public UserController(ApplicationDBContext context, IUserRepository userRepository, ITokenService tokenService)
        {   
            _userRepo = userRepository;
            _tokenService = tokenService;
            _context = context;
        }

        [HttpGet]
        //[Authorize]
        public async Task<IActionResult> GetUsers()
        {   
            var users = await _userRepo.GetAllAsync();
            var usersDto = users.Select(u => u.ToUserDto());

            return Ok(usersDto);
        }

        [HttpGet("{id}")]
        [Authorize]
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

            return Ok(
                new LoginResponseDto
                {
                    Name = userModel.Name,
                    Email = userModel.Email,
                    Token = _tokenService.CreateToken(userModel)
                }
            );
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto userDto)
        {
            var user = await _userRepo.GetByEmailAsync(userDto.Email);

            if(user == null)
            {
                return NotFound();
            }

            if(user.Password != userDto.Password)
            {
                return Unauthorized();
            }

            await _userRepo.SetUserOnline(userDto.Lat, userDto.Lon, userDto.TokenDevice);

            return Ok(
                new LoginResponseDto
                {
                    Name = user.Name,
                    Email = user.Email,
                    Token = _tokenService.CreateToken(user)
                }
            );
        }

        [HttpPost("logout")]
        public async Task<IActionResult> Logout([FromBody] LogoutDto logoutDto)
        {

            await _userRepo.RemoveUserOnline(logoutDto.TokenDevice);

            return Ok();
        }
    }
}
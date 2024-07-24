using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Distributed;

namespace api.Controllers
{   
    [Route("redis")]
    [ApiController]
    public class RedisController : ControllerBase
    {
        private readonly IDistributedCache _cache;

        public RedisController(IDistributedCache cache)
        {
            _cache = cache;
        }

        [HttpPost]
        public IActionResult setUserOnline(int id, string lat, string lon, string deviceToken)
        {
            var user = new
            {
                id,
                lat,
                lon,
                deviceToken
            };

            var userJson = System.Text.Json.JsonSerializer.Serialize(user);
            _cache.SetString("user:" + id, userJson);

            return Ok();
        }

        [HttpGet]
        public List<object> getUsersOnline()
        {
            var usersOnline = new List<object>();

            for (int i = 1; i <= 100; i++) // Supondo que o ID máximo do usuário seja 100
            {
                var json = _cache.GetString("user:" + i);
                if (!string.IsNullOrEmpty(json))
                {
                    var user = System.Text.Json.JsonSerializer.Deserialize<object>(json);
                    usersOnline.Add(user!);
                }
            }

            return usersOnline;
        }
    }
}
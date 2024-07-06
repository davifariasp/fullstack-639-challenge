using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using dotenv.net;
using api.Services;
using api.Dtos.Notification;

namespace api.Controllers
{
    public class WatherController : ControllerBase
    {      
        private readonly FirebaseNotificationService _notificationService;

        public WatherController(FirebaseNotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        [HttpGet("wather/{lat}&{lon}")]   
        public async Task<IActionResult> GetWather([FromRoute] double lat, [FromRoute] double lon)
        {      
            //pegando a chave da api do arquivo .env
            var envVars = DotEnv.Read();
            var API_KEY = envVars["API_KEY"];

            HttpClient client = new HttpClient();

            try {
                var response = await client.GetAsync($"http://api.weatherapi.com/v1/current.json?key={API_KEY}&q={lat},{lon}&aqi=no");

                var content = await response.Content.ReadAsStringAsync();

                return Ok(content);
            } catch (Exception e) {
                return BadRequest(e.Message);
            }
        }

        [HttpPost("notification")]
        public async Task<IActionResult> SendNotification([FromBody] NotificationRequest request)
        {   
            try {
                await _notificationService.SendNotificationAsync(request.Token, request.Title, request.Body);
                return Ok();
            } catch (Exception e) {
                return BadRequest(e.Message);
            }
        }

    }
}
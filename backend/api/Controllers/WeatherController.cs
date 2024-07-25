using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using dotenv.net;
using api.Dtos.Notification;
using api.Interfaces;
using api.Dtos.WeatherAlert;
using api.Mappers;

namespace api.Controllers
{   
    [Route("weather")]
    [ApiController]
    public class WeatherController : ControllerBase
    {      
        private readonly IFirebaseNotificationService _notificationService;
        private readonly IWeatherAlert _weatherAlertRepository;

        public WeatherController (IWeatherAlert weatherAlertRepository, IFirebaseNotificationService notificationService)
        {   
            _weatherAlertRepository = weatherAlertRepository;
            _notificationService = notificationService;
        }
        
        //[Authorize]
        [HttpPost("alert")]
        public async Task<IActionResult> createWeatherAlert([FromBody] CreateWeatherAlertRequestDto weatherAlertDto)
        {
            var weatherAlert = weatherAlertDto.ToWeatherAlertFromCreateDTO();
            await _weatherAlertRepository.CreateAsync(weatherAlert);
            return Ok(
                new WeatherAlertDto{
                    Title = weatherAlert.Title,
                    Lat = weatherAlert.Lat,
                    Lon = weatherAlert.Lon,
                    Running = weatherAlert.Running
                }
            );
        }
        
        [HttpGet("alert")]
        public async Task<IActionResult> listWeatherAlert()
        {
            return Ok(
                await _weatherAlertRepository.GetAllAsync()
            );
        }

        [Authorize]
        [HttpGet("{lat}&{lon}")]   
        public async Task<IActionResult> GetWeather([FromRoute] double lat, [FromRoute] double lon)
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
                await _notificationService.SendNotificationAsync(request.TokenDevice, request.Title, request.Body);
                return Ok();
            } catch (Exception e) {
                return BadRequest(e.Message);
            }
        }

    }
}
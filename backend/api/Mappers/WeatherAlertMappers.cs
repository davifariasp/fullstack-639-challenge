using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Dtos.WeatherAlert;
using api.Models;

namespace api.Mappers
{
    public static class WeatherAlertMappers
    {
        public static WeatherAlertDto ToWeatherAlertDto(this WeatherAlert weatherAlert)
        {
            return new WeatherAlertDto
            {
                Title = weatherAlert.Title,
                Lat = weatherAlert.Lat,
                Lon = weatherAlert.Lon,
                Running = weatherAlert.Running
            };
        }

        public static WeatherAlert ToWeatherAlertFromCreateDTO(this CreateWeatherAlertRequestDto weatherAlertDto)
        {
            Random random = new Random();
            int intRandom = random.Next(100);

            return new WeatherAlert
            {   
                Id = intRandom,
                Title = weatherAlertDto.Title,
                Lat = weatherAlertDto.Lat,
                Lon = weatherAlertDto.Lon,
                Running = weatherAlertDto.Running
            };
        }
    }
}
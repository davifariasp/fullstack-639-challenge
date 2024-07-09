using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Dtos.WeatherAlert
{
    public class WeatherAlertDto
    {
        public int? Id { get; set; }
        public string? Title { get; set; }
        public double? Lat { get; set; }
        public double? Lon { get; set; }
        public bool? Running { get; set; }
    }
}
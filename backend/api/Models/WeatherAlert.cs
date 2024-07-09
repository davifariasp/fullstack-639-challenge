using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Models
{
    public class WeatherAlert
    {
        public int? Id { get; set; }
        public string? Title { get; set; }
        public double? Lat { get; set; }
        public double? Lon { get; set; }
        public bool? Running { get; set; }
    }
}
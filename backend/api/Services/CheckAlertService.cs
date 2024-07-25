using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Dtos.User;
using api.Interfaces;
using api.Models;

namespace api.Services
{
    public class CheckAlertService : BackgroundService
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly ILogger<CheckAlertService> _logger;

        public CheckAlertService(ILogger<CheckAlertService> logger, IServiceScopeFactory serviceScopeFactory)
        {
            _logger = logger;
            _serviceScopeFactory = serviceScopeFactory;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using (var scope = _serviceScopeFactory.CreateScope())
                {   
                    var UserRepository = scope.ServiceProvider.GetRequiredService<IUserRepository>();
                    var weatherAlertRepository = scope.ServiceProvider.GetRequiredService<IWeatherAlert>();
                    var notificationService = scope.ServiceProvider.GetRequiredService<IFirebaseNotificationService>();

                    await CheckAlertsAndNotify(UserRepository, weatherAlertRepository, notificationService);
                }

                await Task.Delay(TimeSpan.FromSeconds(10), stoppingToken);
            }
        }

        private async Task CheckAlertsAndNotify(IUserRepository userRepository, IWeatherAlert weatherAlertRepository, IFirebaseNotificationService notificationService)
        {
            _logger.LogInformation("Verificando alertas e enviando notificações.");

            List<WeatherAlert> alerts = await weatherAlertRepository.GetAllAsync();
            List<UserOnlineDto> users = await userRepository.GetUsersOnline();

            if(users.Count == 0)
            {
                Console.WriteLine("0 usuarios");
            }
         
            users.ForEach(user => {
                Console.WriteLine("entrou aqui");
                Console.WriteLine(user.Lat);
                if (alerts.Any(alert => alert.Lat == user.Lat && alert.Lon == user.Lon))
                {
                    notificationService.SendNotificationAsync(user.TokenDevice!, "Alerta de clima", "Há um alerta de clima na sua cidade.");
                }
            });
        }

    }
}
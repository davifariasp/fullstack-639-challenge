using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Interfaces;
using FirebaseAdmin.Messaging;

namespace api.Services
{
    public class FirebaseNotificationService : IFirebaseNotificationService
    {
        public async Task SendNotificationAsync(string tokenDevice, string title, string body)
        {
            var message = new Message()
        {
            Token = tokenDevice,
            Notification = new Notification()
            {
                Title = title,
                Body = body
            }
        };

        string response = await FirebaseMessaging.DefaultInstance.SendAsync(message);
        Console.WriteLine("Successfully sent message: " + response);
        }
    }
}
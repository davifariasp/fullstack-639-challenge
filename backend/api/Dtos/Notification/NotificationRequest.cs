using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Dtos.Notification
{
    public class NotificationRequest
    {
        public string TokenDevice { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
    }
}
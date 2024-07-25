using System;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace api.Dtos.User
{
    public class UserOnlineDto
    {
        [JsonPropertyName("lat")]
        public double? Lat { get; set; }
        
        [JsonPropertyName("lon")]
        public double? Lon { get; set; }
        
        [JsonPropertyName("tokenDevice")]
        public string? TokenDevice { get; set; }

        // Método de fábrica estático para criar UserOnlineDto a partir do JSON
        public static UserOnlineDto FromJson(string json)
        {
            Console.WriteLine("JSON de entrada:");
            Console.WriteLine(json);

            if (string.IsNullOrWhiteSpace(json))
            {
                Console.WriteLine("JSON está vazio ou nulo.");
                return new UserOnlineDto();
            }

            try
            {
                var userOnlineDto = JsonSerializer.Deserialize<UserOnlineDto>(json, new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                });

                if (userOnlineDto != null)
                {
                    Console.WriteLine("Desserialização bem-sucedida:");
                    Console.WriteLine($"Lat: {userOnlineDto.Lat}");
                    Console.WriteLine($"Lon: {userOnlineDto.Lon}");
                    Console.WriteLine($"TokenDevice: {userOnlineDto.TokenDevice}");
                }
                else
                {
                    Console.WriteLine("Desserialização falhou: o resultado é null.");
                }

                return userOnlineDto!;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Erro durante a desserialização:");
                Console.WriteLine(ex.Message);
                throw;
            }
        }
    }
}

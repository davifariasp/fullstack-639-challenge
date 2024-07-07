import 'dart:convert';
import 'package:app/Interfaces/i_weather_repository.dart';
import 'package:app/Services/http_use.dart';
import 'package:app/utils.dart';

class WeatherRepository extends IWeatherRepository {
  final HttpUse httpUse = HttpUse();

  @override
  Future<dynamic> getWeather({required double lat, required double lon}) async {
    final response = await httpUse.get(
      url: '$baseUrl/weather/$lat&$lon',
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return {'message': 'Erro ao carregar clima'};
    }
  }
}

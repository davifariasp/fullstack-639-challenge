abstract class IWeatherRepository {
  Future getWeather({required String token, required double lat, required double lon});
}

import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weeather/model/city.dart';
import 'package:weeather/model/forecast.dart';
import 'package:weeather/model/weather.dart';
import 'package:weeather/repository/dto/weather_dto.dart';

class WeatherApiClient {
  final http.Client httpClient;
  static const String _url = 'https://api.openweathermap.org/data/2.5/weather?';
  static const String findByCityName = 'q=';
  static const String findByLocationLat = 'lat=';
  static const String findByLocationLon = '&lon=';
  static const String units = '&units=metric';
  static const String detailApiKey = '&appid=';
  static const String _apiKey = 'cbdb86586c0be26b0ddc728da9f8f3b1';


  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Weather> fetchWeather(String name) async {
    final String weatherUrl = '$_url' +
        '$findByCityName' +
        '$name' +
        '$detailApiKey' +
        '$_apiKey' +
        '$units';
    return getData(weatherUrl);
  }

  Future<Weather> findByLocation(double lat, double lon) async {
    final String weatherUrl = '$_url' +
        '$findByLocationLat' +
        '$lat' +
        '$findByLocationLon' +
        '$lon' +
        '$detailApiKey' +
        '$_apiKey' +
        '$units';
    return getData(weatherUrl);
  }

  Future<Weather> getData(String weatherUrl) async {
    final response = await http.get(weatherUrl);
    if (response.statusCode == 200) {
      final jso = json.decode(response.body);
      final WeatherDto result = WeatherDto.fromJson(jso);

      final Forecast forecast = Forecast(
        timeZone: DateTime.fromMillisecondsSinceEpoch(result.timezone * 1000),
        day: DateTime.fromMillisecondsSinceEpoch(result.dt * 1000),
        temp: result.temperature.temp,
        wind: result.wind.speed,
        humidity: result.temperature.humidity,
        icon: result.weather[0].icon,
        sunrise: DateTime.fromMillisecondsSinceEpoch(result.sys.sunrise),
        sunset: DateTime.fromMillisecondsSinceEpoch(result.sys.sunset),
      );

      final City city = City(
        cityId: result.id,
        name: result.name,
        lat: result.coord.lat,
        lon: result.coord.lon,
        country: result.sys.country,
      );

      final List<Forecast> forecasts = List<Forecast>();
      forecasts.add(forecast);
      final Weather weather = Weather(
        city,
        forecasts,
        DateTime.now(),
      );
      return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

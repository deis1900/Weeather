import 'dart:async';

import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:weeather/model/weather.dart';
import 'package:weeather/repository/location/location_client.dart';
import 'package:weeather/repository/weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeatherByLocation() async {
    LocationClient locationClient = LocationClient();
    final LocationData locationData = await locationClient.getCurrentLocation();

    return weatherApiClient.findByLocation(
        locationData.latitude, locationData.longitude);
  }

  Future<Weather> getWeatherByCity(String city) {
    return weatherApiClient.fetchWeather(city);
  }
}

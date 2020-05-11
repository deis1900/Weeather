import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent{
  final String cityName;

  const FetchWeather({@required this.cityName}) : assert(cityName != null);

  @override
  List<Object> get props => [cityName];
}

// TODO: refresh if lastUpdate > 1 hours
class RefreshWeather extends WeatherEvent {
  final String cityName;

  const RefreshWeather({@required this.cityName}) : assert(cityName != null);

  @override
  List<Object> get props => [cityName];
}

class LocationWeather extends WeatherEvent{

  @override
  List<Object> get props {
    return [];
  }
}
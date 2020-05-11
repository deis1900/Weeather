import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final DateTime day;
  final double temp;
  final double wind;
  final int humidity;
  final String icon;
  final DateTime sunrise;
  final DateTime sunset;

  const Forecast({this.day, this.temp, this.wind,
      this.humidity, this.icon, this.sunrise, this.sunset,});

  @override
  List<Object> get props => [
    day,
    temp,
    wind,
    humidity,
    icon,
    sunrise,
    sunset,
  ];
}


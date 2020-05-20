import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final DateTime timeZone;
  final DateTime day;
  final double temp;
  final double wind;
  final int humidity;
  final String icon;
  final DateTime sunrise;
  final DateTime sunset;

  const Forecast({this.timeZone, this.day, this.temp, this.wind,
      this.humidity, this.icon, this.sunrise, this.sunset,});

  @override
  List<Object> get props => [
    timeZone,
    day,
    temp,
    wind,
    humidity,
    icon,
    sunrise,
    sunset,
  ];
}


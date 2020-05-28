import 'package:json_annotation/json_annotation.dart';

part 'weather_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDto {
  final int dt;
  final String name;
  final Sys sys;
  @JsonKey(name: 'main')
  final Temperature temperature;
  final Coord coord;
  @JsonKey(name: 'weather')
  final List<WeatherServer> weather;
  final Wind wind;
  final int id;
  final int timezone;

  WeatherDto(this.dt, this.name, this.sys, this.temperature, this.coord,
      this.weather, this.wind, this.id, this.timezone);

    factory WeatherDto.fromJson(Map<String, dynamic> json) =>
        _$WeatherDtoFromJson(json);

    Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);
}

@JsonSerializable()
class Sys {
  final String country;
  final int sunrise;
  final int sunset;

  Sys(this.country, this.sunrise, this.sunset);

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
class Coord {
  final double lon;
  final double lat;

  Coord(this.lon, this.lat);

  factory Coord.fromJson(Map<String, dynamic> json) =>
      _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
@JsonKey(name: 'weather')
class WeatherServer {
  final String main;
  final String description;
  final String icon;

  WeatherServer(this.main, this.description, this.icon);

  factory WeatherServer.fromJson(Map<String, dynamic> json) {
    return _$WeatherServerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherServerToJson(this);
}

@JsonSerializable()
class Wind {
  final double speed;
  final int deg;

  Wind(this.speed, this.deg);

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Temperature {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;
  final int humidity;

  Temperature(this.temp, this.feelsLike, this.tempMin, this.tempMax,
      this.pressure, this.humidity);

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}

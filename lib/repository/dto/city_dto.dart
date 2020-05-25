import 'package:json_annotation/json_annotation.dart';
import 'package:weeather/repository/dto/weather_dto.dart';


part 'city_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CityDto {
  int id;
  String name;
  String country;
  Coord coord;

  CityDto(this.id, this.name, this.country, this.coord);

  factory CityDto.fromJson(Map<String, dynamic> json) =>
      _$CityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CityDtoToJson(this);


}
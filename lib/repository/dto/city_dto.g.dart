// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityDto _$CityDtoFromJson(Map<String, dynamic> json) {
  return CityDto(
    json['id'] as int,
    json['name'] as String,
    json['country'] as String,
    json['coord'] == null
        ? null
        : Coord.fromJson(json['coord'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CityDtoToJson(CityDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'coord': instance.coord?.toJson(),
    };

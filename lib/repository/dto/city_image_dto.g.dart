// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityImageDto _$CityImageDtoFromJson(Map<String, dynamic> json) {
  return CityImageDto(
    json['page'] as int,
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CityImageDtoToJson(CityImageDto instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['width'] as int,
    json['height'] as int,
    json['description'] as String,
    json['alt_description'] as String,
    json['urls'] == null
        ? null
        : Urls.fromJson(json['urls'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'description': instance.description,
      'alt_description': instance.altDescription,
      'urls': instance.urls,
      'user': instance.user,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    json['regular'] as String,
    json['small'] as String,
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'regular': instance.regular,
      'small': instance.small,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
    };

import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'city_image_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CityImageDto {
  int page;
  List<Result> results;

  CityImageDto(this.page, this.results);

  factory CityImageDto.fromJson(Map<String, dynamic> json) {
    return _$CityImageDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityImageDtoToJson(this);
}

@JsonSerializable()
@JsonKey(name: 'results')
class Result {
  int width;
  int height;
  String description;
  @JsonKey(name: 'alt_description')
  String altDescription;
  Urls urls;
  User  user;

  Result(this.width, this.height, this.description, this.altDescription,
      this.urls, this.user);

  factory Result.fromJson(Map<String, dynamic> json){
    return _$ResultFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Urls {
  String regular;
  String small;

  Urls(this.regular, this.small);

  factory Urls.fromJson(Map<String, dynamic> json) {
    return _$UrlsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

@JsonSerializable()
class User {
  String username;

  User(this.username);

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

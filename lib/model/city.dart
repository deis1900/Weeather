import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int cityId;
  final String name;
  final double lat;
  final double lon;
  final String country;

// TODO: add parameter image (from repository)
  City({this.cityId, this.name, this.lat, this.lon, this.country,});

  @override
  List<Object> get props => [
    cityId,
    name,
    lat,
    lon,
    country,
  ];

}


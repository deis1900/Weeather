import 'package:equatable/equatable.dart';

import 'city.dart';

class CityImage extends Equatable{
  final String url;
  final City city;

  CityImage(this.url, this.city);

  @override
  List<Object> get props => [
    url,
    city
  ];
  }
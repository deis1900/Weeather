import 'package:equatable/equatable.dart';

class CityImage extends Equatable {
  final String url;
  final String photographer;

  CityImage(this.url, this.photographer);

  @override
  List<Object> get props => [
        url,
        photographer,
      ];
}

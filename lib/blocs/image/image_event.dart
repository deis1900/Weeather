import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weeather/model/city.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class FetchImage extends ImageEvent {
  final City city;

  const FetchImage({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [];
}

class RefreshImage extends ImageEvent {
  final City city;

  const RefreshImage({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [];
}

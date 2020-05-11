import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weeather/model/city_image.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class MainImage extends ImageState {
  final String url;
  const MainImage({@required this.url}) : assert(url != null);
  @override
  List<Object> get props => [url];
}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final CityImage image;

  const ImageLoaded({@required this.image}) : assert(image != null);

  @override
  List<Object> get props => [image];
}

class ImageError extends ImageState {}

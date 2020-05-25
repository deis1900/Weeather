import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:weeather/blocs/image/image_event.dart';
import 'package:weeather/blocs/image/image_state.dart';
import 'package:weeather/model/city_image.dart';
import 'package:weeather/repository/image_repository.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;

  ImageBloc({@required this.imageRepository}) : assert(imageRepository != null);

  @override
  ImageState get initialState => MainImage(url: imageRepository.getMainImage());

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is FetchImage) {
      yield* _mapFetchImageToState(event);
    } else if (event is RefreshImage) {
      yield* _mapRefreshImageToState(event);
    }
  }

  Stream<ImageState> _mapFetchImageToState(FetchImage event) async* {
    yield ImageLoading();
    try {
      final CityImage cityImage = await imageRepository.fetchImage(event.city);
      yield ImageLoaded(image: cityImage);
    } catch (_) {
      yield ImageError();
    }
  }

  Stream<ImageState> _mapRefreshImageToState(RefreshImage event) async* {
    yield ImageLoading();
    try {
      final CityImage cityImage = await imageRepository.fetchImage(event.city);
      yield ImageLoaded(image: cityImage);
    } catch (_) {
      yield ImageError();
    }
  }
}

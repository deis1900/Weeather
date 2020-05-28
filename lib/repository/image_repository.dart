import 'package:flutter/cupertino.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/model/city_image.dart';
import 'package:weeather/repository/image_api_client.dart';

class ImageRepository {
  final ImageApiClient imageApiClient;

  ImageRepository({@required this.imageApiClient})
      : assert(imageApiClient != null);

  String getMainImage() {
    return'https://media.gettyimages.com/photos/the-city-of-dreams-new-york'
              '-citys-skyline-at-twilight-picture-id599766748?s=2048x2048';
  }

  Future<List<CityImage>> fetchImage(City city) async {
    return await imageApiClient.fetchImage(city);
  }

}

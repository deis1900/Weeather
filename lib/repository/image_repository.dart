import 'package:flutter/cupertino.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/model/city_image.dart';
import 'package:weeather/repository/image_api_client.dart';

class ImageRepository {
  final ImageApiClient imageApiClient;

  ImageRepository({@required this.imageApiClient})
      : assert(imageApiClient != null);

  String getMainImage() {
    return imageApiClient.getImage();
  }

  Future<CityImage> fetchImage(City city){
    return imageApiClient.fetchImage(city);
  }
}

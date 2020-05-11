import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weeather/model/city.dart';
import 'package:weeather/model/city_image.dart';

class ImageApiClient {
  final http.Client httpClient;
  static const String _url = 'https://api.openweathermap.org/data/2.5/weather?';
  static const String findByLocationLat = 'lat=';
  static const String findByLocationLon = '&lon=';

  ImageApiClient({@required this.httpClient}) : assert(httpClient != null);

  // TODO : Delete (Temp method)
  String getImage() {
    return 'https://media.gettyimages.com/photos/the-city-of-dreams-new-york-citys-skyline-at-twilight-picture-id599766748?s=2048x2048';
  }

  Future<CityImage> fetchImage(City city) async {
    String imageUrl
     = 'https://tatra-yug.com.ua/wp-content/uploads/2016/02/vellington.jpg';
//    if (city.name != null) {
//      imageUrl = '$_url/${city.name}';
//    } else if (city.lon != null && city.lat != null) {
//      imageUrl = '$_url/${city.lat}&${city.lon}';
//    }
//    await getData(imageUrl).then((value) => CityImage(value, city));
    return CityImage(imageUrl, city);
  }

  Future<String> getData(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final image = json.decode(response.body);
      print(image);
      return image;
    }
  }
}

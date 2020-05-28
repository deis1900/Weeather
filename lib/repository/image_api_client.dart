import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weeather/model/city.dart';
import 'package:weeather/model/city_image.dart';

import 'dto/city_image_dto.dart';

class ImageApiClient {
  final http.Client httpClient;
  static const String url = 'https://api.unsplash.com/search/photos?page=1';
  static const String key = 'DXtZdXqWgpGO_ZhL69yOCmgkLs2Jx6rX9rlDSnZmQZc';

  ImageApiClient({@required this.httpClient}) : assert(httpClient != null);

  String getUrl(City city) {
    return url +
        '&query=${city.name} ${city.country}' +
        '&client_id=' +
        key +
        '&collections = city building' +
        '&orientation = squarish';
  }

  Future<List<CityImage>> fetchImage(City city) async {
    final response = await http.get(getUrl(city));
    if (response.statusCode == 200) {
      final jso = json.decode(response.body);
      final CityImageDto data = CityImageDto.fromJson(jso);

      List<CityImage> cityImages = List();
      data.results.forEach(
        (element) {
          cityImages.add(_filterByCityName(city, element));
        },
      );
      return cityImages;
    } else {
      debugPrint('Status code not 200 + ${response.statusCode}');
      throw Exception('Status code not 200 + ${response.statusCode}');
    }
  }

  CityImage _filterByCityName(City city, Result result) {
    CityImage cityImage = CityImage(result.urls.regular, result.user.username);
//    if (result.description.contains(city.name) ||
//        result.altDescription.contains(city.name)) {
//      cityImage = CityImage(
//          (result.urls.regular.isNotEmpty)
//              ? result.urls.regular
//              : result.urls.small,
//          result.user.username);
//    }
    return cityImage;
  }
}

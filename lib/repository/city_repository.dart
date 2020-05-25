import 'dart:collection';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:weeather/model/city.dart';

import 'dto/city_dto.dart';

class CityRepository {
  CityRepository();

  UnmodifiableListView<City> _cities;

  Future<List<City>> searchCity(String query) async {
    List<City> searchedList = (await _cachedCities())
        .where(
          (city) => city.name.toLowerCase().startsWith(query.toLowerCase()),
        )
        .toList();
    return searchedList;
  }

  Future<UnmodifiableListView<City>> _getListOfCities() async {
    try {
      String rawString = await rootBundle.loadString('assets/city.list.json');
      final List<dynamic> jsonList = json.decode(rawString) as List;

      final cities = jsonList.map((cityJson) => CityDto.fromJson(cityJson)).map(
            (cityDto) => City(
              cityId: cityDto.id,
              name: cityDto.name,
              country: cityDto.country,
              lat: cityDto.coord.lat,
              lon: cityDto.coord.lon,
            ),
          );
      return UnmodifiableListView(cities);
    } catch (e) {
      debugPrint('Error Parsing Response Body (City)' + e); // TODO: this line do nothing
      throw e;
    }
  }

  Future<List<City>> _cachedCities() async {
    if (_cities == null) {
      _cities = await _getListOfCities();
    }
    return _cities;
  }
}

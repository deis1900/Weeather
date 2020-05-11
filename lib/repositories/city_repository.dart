import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:weeather/model/city.dart';
import 'package:weeather/repositories/dto/city_dto.dart';

class CityRepository {
   static List<City> _cities;
  CityRepository();

  Future<String> _loadAsset() async {
    try {
      var cityJson = await rootBundle.loadString('assets/city.list.json');
      return cityJson;
    } catch (_) {
      Exception('Error Downloading File Data');
    }
  }

  Future<List<City>> getListOfCities() async {
    if (_cities == null) {
      try {
        String rawString = await _loadAsset();
        final List<dynamic> jsonList = json.decode(rawString) as List;

        return jsonList
            .map((cityJson) => CityDto.fromJson(cityJson))
            .map(
              (cityDto) =>
              City(
                cityId: cityDto.id,
                name: cityDto.name,
                country: cityDto.country,
                lat: cityDto.coord.lat,
                lon: cityDto.coord.lon,
              ),
        )
            .toList();
      } catch (e) {
        debugPrint(e);
        Exception('Error Parsing Response Body (City)');
        throw e;
      }
    }
    return _cities;
  }

  Future<List<City>> getSortCityList(String enteredCity) async {
    await Future.delayed(Duration(milliseconds: 300));
    final cities = await getListOfCities();
    List<City> searchedList = cities
        .where((city) => city.name.contains(enteredCity, 0))
        .toList();
    return searchedList;
  }
}

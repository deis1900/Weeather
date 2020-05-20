import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:weeather/model/city.dart';
import 'package:weeather/repositories/dto/city_dto.dart';

class CityRepository {
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
    List<City> _cities;
    if (_cities == null) {
      try {
        String rawString = await _loadAsset();
        final List<dynamic> jsonList = json.decode(rawString) as List;

        _cities = jsonList
            .map((cityJson) => CityDto.fromJson(cityJson))
            .map(
              (cityDto) => City(
                cityId: cityDto.id,
                name: cityDto.name,
                country: cityDto.country,
                lat: cityDto.coord.lat,
                lon: cityDto.coord.lon,
              ),
            )
            .toList();
        return _cities;
      } catch (e) {
        debugPrint(e);
        Exception('Error Parsing Response Body (City)');
        throw e;
      }
    }
    return _cities;
  }

  Future<List<City>> getSortCityList(
      bool reloaderList, String enteredCity) async {
    await Future.delayed(Duration(milliseconds: 300));
    final cityList = await getListOfCities();
    if (!reloaderList) {
      List<City> searchedList = cityList
          .where((city) =>
              city.name.toLowerCase().startsWith(enteredCity.toLowerCase(), 0))
          .toList();
      return searchedList;
    }
    return cityList;
  }
}

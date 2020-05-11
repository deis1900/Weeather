import 'package:equatable/equatable.dart';
import 'package:weeather/model/city.dart';
import 'package:meta/meta.dart';

abstract class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object> get props => [];
}

class EmptyCityState extends CitySearchState {}

class LoadingCityState extends CitySearchState {}

class SearchedCitiesState extends CitySearchState {
  final List<City> cities;

  const SearchedCitiesState({@required this.cities}) : assert(cities != null);

  @override
  List<Object> get props => [cities];
}

class LoadedAllCitiesState extends CitySearchState {
  final List<City> cities;

  const LoadedAllCitiesState({@required this.cities}) : assert(cities != null);

  @override
  List<Object> get props => [cities];
}

class ErrorState extends CitySearchState {}

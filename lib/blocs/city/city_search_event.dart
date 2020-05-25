import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();
}

class SearchEvent extends CitySearchEvent {
  final String enteredCity;

  const SearchEvent({@required this.enteredCity})
      : assert(enteredCity != null);

  @override
  List<Object> get props => [enteredCity];
}

class LoadCityListEvent extends CitySearchEvent {
  const LoadCityListEvent();

  @override
  List<Object> get props => [];
}

class PerformSearch extends CitySearchEvent {
  final String searchQuery;

  PerformSearch(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}
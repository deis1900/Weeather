import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CitySearchEvent extends Equatable{
  const CitySearchEvent();
}

class SearchEvent extends CitySearchEvent {
  final String enteredCity;

  const SearchEvent({@required this.enteredCity}) : assert(enteredCity != null);

  @override
  List<Object> get props => [enteredCity];
}
class LoadCitiesListEvent extends CitySearchEvent{

  const LoadCitiesListEvent();

  @override
  List<Object> get props => [];
}

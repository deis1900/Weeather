import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weeather/repositories/city_repository.dart';

import 'city_search_event.dart';
import 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityRepository cityRepository;

  CitySearchBloc({@required this.cityRepository})
      : assert(cityRepository != null);

  @override
  CitySearchState get initialState => EmptyCityState();

  @override
  Stream<CitySearchState> mapEventToState(CitySearchEvent event) async* {
    yield LoadingCityState();
    if (event is SearchEvent) {
      yield* _mapSortCitiesToState(event.enteredCity);
    }
  }

  Stream<CitySearchState> _mapSortCitiesToState(String enteredCity) async* {
    try {
      final cities = await cityRepository.getSortCityList(enteredCity);
      if (cities.first != null) {
        yield SearchedCitiesState(cities: cities);
      }
    } catch (_) {
      yield ErrorState();
    }
  }
}

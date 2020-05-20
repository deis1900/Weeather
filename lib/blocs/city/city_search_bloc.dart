import 'dart:async';

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
  CitySearchState get initialState => LoadingCityState();

  @override
  Stream<CitySearchState> mapEventToState(CitySearchEvent event) async* {
    yield LoadingCityState();
    try {
      final cities = await cityRepository.getListOfCities();
      if (cities.first != null) {
        yield SearchedCitiesState(cities: cities);
      }
    } catch (_) {
      yield ErrorState();
    }
    if (event is SearchEvent) {
      yield* _mapSortCitiesToState(event.reloaderList, event.enteredCity);
    }
  }

  Stream<CitySearchState> _mapSortCitiesToState(
      bool reloaderList, String enteredCity) async* {
    final int _timer = 900;
    bool _sendRequest = false;

    Timer(Duration(milliseconds: _timer), () {
      _sendRequest = true;
    });

    if (!_sendRequest) {
      yield LoadingCityState();
    }

    try {
      final cities =
          await cityRepository.getSortCityList(reloaderList, enteredCity);
      if (cities.first != null) {
        yield SearchedCitiesState(cities: cities);
      }
    } catch (_) {
      yield ErrorState();
    }
  }
}

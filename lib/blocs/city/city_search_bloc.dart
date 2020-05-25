import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:weeather/repository/city_repository.dart';

import 'city_search_event.dart';
import 'city_search_state.dart';

const Duration _inputThreshold = Duration(milliseconds: 500);

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityRepository cityRepository;

  CitySearchBloc({@required this.cityRepository})
      : assert(cityRepository != null);

  Timer _timer;

  @override
  CitySearchState get initialState => LoadingCityState();

  @override
  Stream<CitySearchState> mapEventToState(CitySearchEvent event) async* {
    if (event is SearchEvent) {
      yield* _mapFilteredCityListState(event.enteredCity);
    } else if (event is PerformSearch) {
      yield* _mapPerformSearch(event);
    }
  }

  Stream<CitySearchState> _mapFilteredCityListState(String enteredCity) async* {
    _timer?.cancel();

    _timer = Timer(_inputThreshold, () {
      add(PerformSearch(enteredCity));
    });
  }

  Stream<CitySearchState> _mapPerformSearch(PerformSearch event) async* {
    try {
      final cities = await cityRepository.searchCity(
        event.searchQuery,
      );
      yield SearchedCitiesState(cities: cities);
    } catch (e) {
      debugPrint(
        'Unable to search city by ${event.searchQuery}' + e.toString(),
      );
      yield CitySearchErrorState(e);
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}

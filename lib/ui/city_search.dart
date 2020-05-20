import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/city/city_search_bloc.dart';
import 'package:weeather/blocs/city/city_search_event.dart';
import 'package:weeather/blocs/city/city_search_state.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/ui/weather_city_page.dart';

class CitySearch extends SearchDelegate<City> {
  City _city;
  bool _reloadList = true;
  String _previousQuery = '';
  final CitySearchBloc cityBloc;

  CitySearch(this.cityBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          _reloadList = true;
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<CitySearchBloc, CitySearchState>(
      bloc: cityBloc,
      builder: (BuildContext context, CitySearchState state) {
        if (state is LoadingCityState) {
          if (_reloadList) {
            _reloadList = false;
            cityBloc.add(SearchEvent(_reloadList, enteredCity: query));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return Container(
            child: Text('Error, cities wasn`t downloaded.'),
          );
        } else if (state is SearchedCitiesState) {
          if (_previousQuery != query) {
            cityBloc.add(SearchEvent(_reloadList, enteredCity: query));
            _previousQuery = query;
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    _city = state.cities[index];
                    showResults(context);
                  },
                  leading: Icon(Icons.location_city),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: state.cities[index].name
                              .substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: state.cities[index].name
                                  .substring(query.length),
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                      Text(' : ' +
                          state.cities[index].country +
                          '  $index of ${state.cities.length}')
                    ],
                  ));
            },
            itemCount: state.cities.length,
          );
        } else {
          debugPrint('The state ${state.runtimeType} is not exists!');
          return Container(
            child: Text('Found UI error. Maybe another time.'),
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (_city != null) {
      return WeatherCityPage(
        city: _city,
      );
    } else
      return Center(
        child: Text('Pease, enter the current city.'),
      );
  }
}

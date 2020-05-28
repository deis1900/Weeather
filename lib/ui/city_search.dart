import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/city/city_search_bloc.dart';
import 'package:weeather/blocs/city/city_search_event.dart';
import 'package:weeather/blocs/city/city_search_state.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/ui/weather_city_page.dart';

class CitySearchDelegate extends SearchDelegate<City> {
  City _city;
  final CitySearchBloc cityBloc;

  CitySearchDelegate(this.cityBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          cityBloc.add(SearchEvent(enteredCity: query));
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
          cityBloc.add(SearchEvent(
              enteredCity: query)); // TODO: check do we need this line
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CitySearchErrorState) {
          return Container(
            child: Text('Error, cities wasn`t downloaded.'),
          );
        } else if (state is SearchedCitiesState) {
          cityBloc.add(SearchEvent(
              enteredCity: query));
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
    if (_city.name.toLowerCase() == query.toLowerCase()) {
      return WeatherCityPage(
        city: _city,
      );
    } else {
      return Center(
        child: Text('Enter the current city.'),
      );
    }
  }
}

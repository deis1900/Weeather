import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/city/city_search_bloc.dart';
import 'package:weeather/blocs/city/city_search_event.dart';
import 'package:weeather/blocs/city/city_search_state.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/ui/weather_city_page.dart';

class CitySearch extends SearchDelegate<City> {
  final CitySearchBloc cityBloc;

  CitySearch(this.cityBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
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
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      cityBloc.add(
        SearchEvent(enteredCity: query),
      );
    return BlocBuilder<CitySearchBloc, CitySearchState>(
      bloc: cityBloc,
      builder: (BuildContext context, CitySearchState state) {
        if (state is EmptyCityState) {
          return Center(child: Text("The list of cities is empty."));
        } else if (state is LoadingCityState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return Container(
            child: Text('Error, cities wasn`t downloaded.'),
          );
        }
//        else if (state is LoadedAllCitiesState) {
//          if (state.cities != null) {
//            return ListView.builder(
//              itemBuilder: (context, index) {
//                return ListTile(
//                  onTap: () {
//                    state.cities.forEach((cityVal) {
//                      if (cityVal.name.toLowerCase() == query.toLowerCase()) {
//                        showResults(context);
//                      }
//                    });
//                  },
//                  leading: Icon(Icons.location_city),
//                  title: RichText(
//                    text: TextSpan(
//                        text:
//                        state.cities[index].name.substring(0, query.length),
//                        style: TextStyle(
//                            color: Colors.black, fontWeight: FontWeight.bold),
//                        children: [
//                          TextSpan(
//                              text: state.cities[index].name
//                                  .substring(query.length),
//                              style: TextStyle(color: Colors.green))
//                        ]),
//                  ),
//                );
//              },
//              itemCount: state.cities.length,
//            );
//          } else {
//            showResults(context);
//            return Container();
//          }
//        }
        else if (state is SearchedCitiesState) {
          if (state.cities.length < 1 && state.cities.first.name == query) {
            return WeatherCityPage(
              city: state.cities[0].name,
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    state.cities.forEach((cityVal) {
                      if (cityVal.name.toLowerCase() == query.toLowerCase()) {
                        showResults(context);
                      }
                    });
                  },
                  leading: Icon(Icons.location_city),
                  title: RichText(
                    text: TextSpan(
                        text:
                        state.cities[index].name.substring(0, query.length),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: state.cities[index].name
                                  .substring(query.length),
                              style: TextStyle(color: Colors.green))
                        ]),
                  ),
                );
              },
              itemCount: state.cities.length,
            );
          }
        } else {
          debugPrint('The state is not exists!');
          return Container(
            child: Text('Found UI error. Maybe another time.'),
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return WeatherCityPage(
      city: query,
    );
  }
}

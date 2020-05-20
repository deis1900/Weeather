import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/city/city_search_bloc.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/weather/weather_bloc.dart';
import 'package:weeather/blocs/weather/weather_event.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/repositories/city_repository.dart';
import 'package:weeather/repositories/image_repository.dart';
import 'package:weeather/repositories/weather_repository.dart';
import 'package:weeather/ui/component/weather_comp.dart';

import 'city_search.dart';
import 'component/image_comp.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Weather createState() => Weather();
}

class Weather extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: 'Weeather',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
      body: Container(
        height: 600,
        child: Column(
          children: <Widget>[
            Container(padding: EdgeInsets.all(5.0),
              color: Colors.black12,
              child: RichText(
                  text: TextSpan(
                      text: 'Weather outside',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black))),
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider<WeatherBloc>(
                    create: (BuildContext context) => WeatherBloc(
                          weatherRepository:
                              RepositoryProvider.of<WeatherRepository>(context),
                        )..add(LocationWeather())),
                BlocProvider<ImageBloc>(
                  create: ((BuildContext context) => ImageBloc(
                      imageRepository:
                          RepositoryProvider.of<ImageRepository>(context))),
                )
              ],
              child: Column(verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  WeatherComponent(),
                  ImageComponent(),
                ],
              ),
            ),
            Container(
              child: Center(
                child: BlocProvider(
                  create: (BuildContext context) => CitySearchBloc(
                      cityRepository:
                          RepositoryProvider.of<CityRepository>(context)),
                  child: Builder(
                    builder: (BuildContext context) {
                      return RaisedButton(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Search city'),
                            Icon(Icons.search)
                          ],
                        ),
                        onPressed: () async {
                          await showSearch<City>(
                            context: context,
                            delegate: CitySearch(
                                BlocProvider.of<CitySearchBloc>(context)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

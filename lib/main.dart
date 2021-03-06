import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weeather/repository/city_repository.dart';
import 'package:weeather/repository/image_api_client.dart';
import 'package:weeather/repository/image_repository.dart';
import 'package:weeather/repository/weather_api_client.dart';
import 'package:weeather/repository/weather_repository.dart';
import 'package:weeather/ui/my_home_page.dart';

import 'blocs/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(
              weatherApiClient: WeatherApiClient(httpClient: http.Client())),
        ),
        RepositoryProvider<ImageRepository>(
          create: (context) => ImageRepository(
              imageApiClient: ImageApiClient(httpClient: http.Client())),
        ),
        RepositoryProvider<CityRepository>(
          create: (context) => CityRepository(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
//ToDo  dark theme
//        darkTheme: ThemeData.dark(),
        title: 'Weeather',
        home: MyHomePage(),
      ),
    );
  }
}

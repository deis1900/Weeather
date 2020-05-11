import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/city/city_search_bloc.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/weather/weather_bloc.dart';
import 'package:weeather/repositories/city_repository.dart';
import 'package:weeather/repositories/image_api_client.dart';
import 'package:weeather/repositories/image_repository.dart';
import 'package:weeather/repositories/weather_api_client.dart';
import 'package:weeather/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weeather/ui/my_home_page.dart';

import 'blocs/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  final ImageRepository imageRepository = ImageRepository(
      imageApiClient: ImageApiClient(
    httpClient: http.Client(),
  ));
  final CityRepository cityRepository = CityRepository();
  runApp(App(
    weatherRepository: weatherRepository,
    imageRepository: imageRepository,
    cityRepository: cityRepository,
  ));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final ImageRepository imageRepository;
  final CityRepository cityRepository;

  App(
      {Key key,
      @required this.weatherRepository,
      @required this.cityRepository,
      @required this.imageRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) =>
              WeatherBloc(weatherRepository: weatherRepository),
        ),
        BlocProvider<ImageBloc>(
          create: (BuildContext context) =>
              ImageBloc(imageRepository: imageRepository),
        ),
        BlocProvider<CitySearchBloc>(
          create: (BuildContext context) => CitySearchBloc(
            cityRepository: cityRepository,
          ),
        )
      ],
      child: MaterialApp(
        title: 'Weeather',
        home: MyHomePage(),
      ),
    );
  }
}

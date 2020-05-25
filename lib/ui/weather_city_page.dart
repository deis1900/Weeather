import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/image/image_event.dart';
import 'package:weeather/blocs/weather/weather_bloc.dart';
import 'package:weeather/blocs/weather/weather_event.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/repository/image_repository.dart';
import 'package:weeather/repository/weather_repository.dart';
import 'package:weeather/ui/component/image_component.dart';
import 'package:weeather/ui/component/weather_component.dart';

class WeatherCityPage extends StatefulWidget {
  final City city;

  const WeatherCityPage({@required this.city}) : assert(city != null);

  @override
  WeatherCityState createState() => WeatherCityState();
}

class WeatherCityState extends State<WeatherCityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Container(
              height: 600,
              color: Colors.black12,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<WeatherBloc>(
                      create: (BuildContext context) => WeatherBloc(
                            weatherRepository:
                                RepositoryProvider.of<WeatherRepository>(
                                    context),
                          )..add(FetchWeather(cityName: widget.city.name))),
                  BlocProvider<ImageBloc>(
                    create: ((BuildContext context) => ImageBloc(
                        imageRepository:
                            RepositoryProvider.of<ImageRepository>(context))
                      ..add(FetchImage(city: widget.city))),
                  )
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Weather  ${widget.city.name.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Colors.black))),
                    // TODO: Must will be created state from Bloc
                    WeatherComponent(),
                    ImageComponent(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/image/image_event.dart';
import 'package:weeather/blocs/image/image_state.dart';
import 'package:weeather/blocs/weather/weather_bloc.dart';
import 'package:weeather/blocs/weather/weather_state.dart';
import 'package:weeather/model/city_image.dart';
import 'package:weeather/model/forecast.dart';

import 'component/weather_tile.dart';

class WeatherCityPage extends StatelessWidget {
  final String city;

  const WeatherCityPage({@required this.city}) : assert(city != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Container(
              height: 600,
              color: Colors.black12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Weather  ${city.toUpperCase()}',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Colors.black))),
                  // TODO: Must will be created state from Bloc
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherEmpty) {
                        return Center(
                            child: Text('Please check settings Location'));
                      }
                      if (state is WeatherLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is WeatherLoaded) {
                        final weather = state.weather;
                        BlocProvider.of<ImageBloc>(context)
                            .add(FetchImage(city: weather.city));
                        return Container(
                          height: 150,
                          color: Colors.lightBlueAccent,
                          child: PageView.builder(
                            itemCount: weather.forecasts.length,
                            itemBuilder: (context, index) {
                              final Forecast forecast =
                                  weather.forecasts[index];
                              return ForecastTile(
                                forecast: forecast,
                              );
                            },
                          ),
                        );
                      }
                      if (state is WeatherError) {
                        return Text(
                          'Something went wrong!',
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        throw Exception('Unknown state!');
                      }
                    },
                  ),

                  // TODO: Must will be created state from Bloc
                  BlocBuilder<ImageBloc, ImageState>(
                    builder: (context, state) {
                      if (state is MainImage) {
                        return Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Image.network(
                              state.url,
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        );
                      }
                      if (state is ImageLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is ImageLoaded) {
                        final CityImage cityPicture = state.image;
                        return Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Image.network(
                              cityPicture.url,
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                          ),
                        );
                      }
                      if (state is ImageError) {
                        return Text(
                          'Something went wrong!',
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        throw Exception('Unknown state!');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

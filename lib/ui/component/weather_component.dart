import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/image/image_event.dart';
import 'package:weeather/blocs/weather/weather_bloc.dart';
import 'package:weeather/blocs/weather/weather_state.dart';
import 'package:weeather/model/forecast.dart';
import 'package:weeather/ui/component/weather_tile.dart';

class WeatherComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherEmpty) {
            return Center(child: Text('Please check settings Location'));
          }
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is WeatherLoaded) {
            final weather = state.weather;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.2],
                    colors: [Colors.blue, Colors.white]),
              ),
              child: PageView.builder(
                itemCount: weather.forecasts.length,
                itemBuilder: (context, index) {
                  BlocProvider.of<ImageBloc>(context)
                      .add(FetchImage(city: weather.city));
                  final Forecast forecast = weather.forecasts[index];
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
    );
  }
}

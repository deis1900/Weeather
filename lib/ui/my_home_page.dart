import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/city/city_search_bloc.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/image/image_event.dart';
import 'package:weeather/blocs/image/image_state.dart';
import 'package:weeather/blocs/weather/weather_bloc.dart';
import 'package:weeather/blocs/weather/weather_event.dart';
import 'package:weeather/blocs/weather/weather_state.dart';
import 'package:weeather/model/city.dart';
import 'package:weeather/model/city_image.dart';
import 'package:weeather/model/forecast.dart';
import 'package:weeather/ui/component/weather_tile.dart';

import 'city_search.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Weather createState() => Weather();
}

class Weather extends State<MyHomePage> {
  ImageBloc imageBloc;
  WeatherBloc weatherBloc;

  @override
  void initState() {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(LocationWeather());
    imageBloc = BlocProvider.of<ImageBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    weatherBloc.close();
    imageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: widget.title,
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 500,
              color: Colors.black12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Weather outside',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
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
                        imageBloc.add(FetchImage(city: weather.city));
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
            Container(
              child: Center(
                child: Builder(
                  builder: (BuildContext context) {
                    return RaisedButton(
                      child: Text('Search city.'),
                      onPressed: () async {
                        City selected = await showSearch<City>(
                          context: context,
                          delegate: CitySearch(
                              BlocProvider.of<CitySearchBloc>(context)),
                        );
                        print(selected);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

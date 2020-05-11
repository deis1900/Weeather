
import 'package:equatable/equatable.dart';
import 'package:weeather/model/city.dart';

import 'forecast.dart';

class Weather extends Equatable{
  final City city;
  final List<Forecast> forecasts;
  final DateTime lastUpdate;


  Weather(this.city, this.forecasts, this.lastUpdate);

  @override
  // TODO: implement props
  List<Object> get props => [
    city,
    forecasts,
    lastUpdate
  ];

}
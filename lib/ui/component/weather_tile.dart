import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weeather/model/forecast.dart';

class ForecastTile extends StatelessWidget {
  final Forecast forecast;
  final urlIcon = 'http://openweathermap.org/img/wn/';

  const ForecastTile({Key key, @required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  DateFormat('EEE dd MMM HH:mm')
                      .format(forecast.day),
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                Image.network(urlIcon + forecast.icon + '@2x.png'),
              ],
            ),
            Column(
              children: [
                Text(
                  '${forecast.temp} C',
                  style: TextStyle(fontSize: 20.0),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${forecast.wind} m/s',
                  style: TextStyle(fontSize: 20.0),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${forecast.humidity} %',
                  style: TextStyle(fontSize: 20.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

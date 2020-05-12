import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weeather/model/forecast.dart';

class ForecastTile extends StatelessWidget {
  final Forecast forecast;
  final urlIcon = 'http://openweathermap.org/img/wn/';

  const ForecastTile({Key key, @required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
          child: Text(
            '${forecast.day.toString().replaceAll(':00.000', '')}',
            style: TextStyle(
              fontSize: 25.0,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.2, 1.2),
                  blurRadius: 5.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Image.network(urlIcon + forecast.icon + '@2x.png'),
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

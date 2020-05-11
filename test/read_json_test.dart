import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weeather/repositories/dto/city_dto.dart';
import 'package:weeather/repositories/dto/weather_dto.dart';

void main() {
  group(
    'cityRepocitory test',
    () {
      test(
        'read json from file',
        () {
          String actual = '[{'
              '"id": 833,'
              '"name": "Ḩeşār-e Sefīd",'
              '"state": "",'
              '"country": "IR",'
              '"coord": '
              '{"lon": 47.159401,'
              '"lat": 34.330502'
              '}'
              '},'
              '{'
              '"id": 2960,'
              '"name": "‘Ayn Ḩalāqīm",'
              '"state": "",'
              '"country": "SY",'
              '"coord": {'
              '"lon": 36.321911,'
              '"lat": 34.940079'
              '}';
          TestWidgetsFlutterBinding.ensureInitialized();
          var jst = rootBundle.loadString('assets/city.list.json');
          print(jst);
          jst.then(
            (matcher) =>
                expect(actual.substring(1, 30), matcher.substring(1, 30)),
          );
        },
      );

      test(
        'serialize city from Json',
        () {
          TestWidgetsFlutterBinding.ensureInitialized();
          List<CityDto> listCityDto = List();
          listCityDto.add(
            CityDto(
              71296900,
              "Голубинка",
              "UA",
              Coord(33.92, 44.59),
            ),
          );
          listCityDto.add(
            CityDto(
              102908597,
              "Gerton",
              "US",
              Coord(-82.348056, 35.479167),
            ),
          );
          listCityDto.add(
            CityDto(
              536203,
              "Saint Petersburg",
              "RU",
              Coord(30.25, 59.916668),
            ),
          );
          var mat;
          rootBundle.loadString('assets/city.list.json').then((value) {
            var listFromJson = CityDto.fromJson(mat) as List;
            print(listFromJson);
            expect(listCityDto, listFromJson);
            expect(listCityDto[2], listFromJson[2]);
          });
        },
      );
    },
  );
}

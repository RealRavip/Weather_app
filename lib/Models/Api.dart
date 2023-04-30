
import 'Air_quality.dart';
import 'Weather.dart';
import 'WeatherApi.dart';
import 'package:http/http.dart' as http;

Future getWeatherData(String lat, String long, WeatherApi _w, air_quaity _a) async {
  final url = Uri.parse("localhost:8080/weather?lat=${lat}&lon=${long}");
  final _Url = Uri.parse("localhost:8080/air-quality");
  var _Wresponse = await http.get(url);
  var _Aresponse = await http.get(_Url);
  print(_Wresponse.body);
  _w = weatherApiFromJson(_Wresponse.body);
  _a = AirqualityFromJson(_Aresponse.body);
}
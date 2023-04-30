import 'AirqualityApi.dart';
import 'Weather.dart';
import 'WeatherApi.dart';
import 'package:http/http.dart' as http;

Future getWeatherData(double lat, double long, WeatherApi _w, AirqualityApi _a) async {
  final url = Uri.parse("localhost:8080/weather?lat=${lat}&lon=${long}");
  final _Url = Uri.parse("localhost:8080/air-quality");
  var _Wresponse = await http.get(url);
  var _Aresponse = await http.get(_Url);
  print(_Wresponse.body);
  _w = weatherApiFromJson(_Wresponse.body);
  _a = AirqualityApiFromJson(_Aresponse.body);
}
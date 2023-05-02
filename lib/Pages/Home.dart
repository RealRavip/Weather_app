import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_station/Models/AirqualityApi.dart';
import 'package:weather_station/Models/WeatherApi.dart';
import 'package:http/http.dart' as http;
import 'package:weather_station/Models/send_api.dart';
import 'package:weather_station/Models/globals.dart' as global;

late WeatherApi _w;
late AirqualityApi _a;

Future getWeatherData(double lat, double long) async {
  final url =
      Uri.parse("http://192.168.1.48:8080/weather?lat=${lat}&lon=${long}");
  final _Url = Uri.parse("http://192.168.1.48:8080/air-quality");
  var _Wresponse = await http.get(url);
  var _Aresponse = await http.get(_Url);
  print(_Wresponse.body);
  print(_Aresponse.body);
  _w = weatherApiFromJson(_Wresponse.body);
  _a = AirqualityApiFromJson(_Aresponse.body);
}

class Home extends StatefulWidget {
  final double currentlat;
  final double currentlong;
  const Home(this.currentlat, this.currentlong, {super.key});

  @override
  State<Home> createState() => _HomeState(this.currentlat, this.currentlong);
}

class _HomeState extends State<Home> {
  String? _currentAddress;
  Position? _currentPosition;
  final double _currentlat;
  final double _currentlong;
  _HomeState(this._currentlat, this._currentlong);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          sendFcmToken(global.DeviceId, global.FCMToken,13.7897448,100.7883344);
          print(_currentlat);
          return Scaffold(
              body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              CurrentWeatherView(_w),
              forcastViewsDaily(),
            ],
          ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getWeatherData(13.7897448, 100.7883344),
    );
  }

  Widget CurrentWeatherView(WeatherApi _w) {
    return Column(
      children: [createAppBar(_w), weatherBox(_w), weatherDetailsBox(_w)],
    );
  }

  Widget forcastViewsDaily() {
    return dailyBoxes();
  }

  Widget createAppBar(WeatherApi w) {
    // Location dropdownValue = locations.first;
    return Container(
        padding:
            const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
        margin: const EdgeInsets.only(
            top: 35, left: 15.0, bottom: 15.0, right: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(60)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
        child: Text(_w.city.name ?? ""));
  }

  Widget weatherBox(WeatherApi _w) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 160.0,
        decoration: BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      ClipPath(
          child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(15.0),
              height: 160.0,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent[400],
                  borderRadius: const BorderRadius.all(Radius.circular(20))))),
      Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 160.0,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                    //getWeatherIcon(_weather.icon),
                    Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Text(
                          "${_w.current.weather[0].description}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                    Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Text(
                          "H:${_w.current.main.tempMax}° L:${_w.current.main.tempMin}°",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.white),
                        )),
                  ])),
              Column(children: <Widget>[
                Container(
                    child: Text(
                  "${_w.current.main.temp.toString()}°" ?? "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.white),
                )),
                Container(
                    margin: const EdgeInsets.all(0),
                    child: Text(
                      "Fell like${_w.current.main.feelsLike}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white),
                    )),
              ])
            ],
          ))
    ]);
  }

  Widget weatherDetailsBox(WeatherApi _w) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
      margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                  child: Text(
                "Wind",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              )),
              Container(
                  child: Text(
                "${_w.current.wind.speed} km/h",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ))
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Container(
                  child: Text(
                "Humidity",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              )),
              Container(
                  child: Text(
                "${_w.current.main.humidity}%",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ))
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Container(
                  child: Text(
                "Pm2.5",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              )),
              Container(
                  child: Text(
                "${_a.data!.aqi}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black),
              ))
            ],
          ))
        ],
      ),
    );
  }

  Widget dailyBoxes() {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      left: 8, top: 0, bottom: 0, right: 8),
                  itemCount: _w.forecasts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 10),
                        margin: const EdgeInsets.all(5),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            "${_w.forecasts[index].day}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )),
                          Expanded(
                              child: Text(
                                  "${_w.forecasts[index].hours[0].forecast.weather[0].description}")),
                          Expanded(
                              child: Text(
                            "${_w.forecasts[index].hours[0].forecast.main.tempMax}/${_w.forecasts[index].hours[0].forecast.main.tempMin}",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )),
                        ]));
                  })),
        ],
      ),
    );
  }


}

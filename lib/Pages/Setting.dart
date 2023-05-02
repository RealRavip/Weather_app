import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/Models/ReminderApi.dart';
import 'package:weather_station/Models/send_api.dart';
import 'package:http/http.dart' as http;

List<ReminderApi> _r = [];
bool Exist = false;
List<String> Airoption = ['PERIODIC', 'TIME_OF_DAY'];
String? selectAirOption = 'PERIODIC';
List<String> Weatheroption = ['PERIODIC', 'TIME_OF_DAY'];
String? selectWeatherOption = 'PERIODIC';
TimeOfDay time = TimeOfDay.now();
TimeOfDay air_time = TimeOfDay.now();
String weather_hour = '';
String weather_minute = '';
String air_hour = '';
String air_minute = '';
// selectWeatherOption = _r[0].option.toString();
// selectAirOption = _r[1].option.toString();
String? Id;
TextEditingController Weather_Controller = TextEditingController();
TextEditingController Air_Controller = TextEditingController();

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
}

Future getReminderData() async {
  Id = await _getId();
  Map<String, String> requestHeaders = {
    'X-Device-ID': '${Id}',
  };

  final url = Uri.parse("http://192.168.1.48:8080/users/reminders");
  var _Wresponse = await http.get(url, headers: requestHeaders);
  print(_Wresponse.body);
  if (_Wresponse.body == 'null') {
  } else {
    Exist = true;
    Iterable body = json.decode(_Wresponse.body);
    _r = List<ReminderApi>.from(
        body.map((model) => ReminderApi.fromJson(model)));
  }
}

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  print_data() async {
    String? Id = await _getId();
    print(Id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_r.isEmpty) {
          } else {
            String weather_hour =
                _r[0].timeOfDay.toString().substring(0, 2).padLeft(2, '0');
            String weather_minute =
                _r[0].timeOfDay.toString().substring(3, 5).padLeft(2, '0');
            String air_hour =
                _r[1].timeOfDay.toString().substring(0, 2).padLeft(2, '0');
            String air_minute =
                _r[1].timeOfDay.toString().substring(3, 5).padLeft(2, '0');
            Weather_Controller = TextEditingController(
                text: _r[0].periodicDuration.toString().substring(0, 2));
            Air_Controller = TextEditingController(
                text: _r[1].periodicDuration.toString().substring(0, 2));
            if (Weather_Controller.text.contains('h')) {
              Weather_Controller = TextEditingController(
                  text: _r[0].periodicDuration.toString().substring(0, 1));
            }
            if (Air_Controller.text.contains('h')) {
              Air_Controller = TextEditingController(
                  text: _r[1].periodicDuration.toString().substring(0, 1));
            }
          }

          return ReminderBox();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getReminderData(),
      //(_currentlat, _currentlong, _w, _a),
    );
  }

  Widget ReminderBox() {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        margin: const EdgeInsets.only(
            top: 35, left: 15.0, bottom: 15.0, right: 15.0),
        child: Column(children: [
          Text("Setting",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          WeatherSetting(),
          SizedBox(height: 10),
          AirSetting(),
        ]),
      ),
      floatingActionButton: AddButton(),
    );
  }

  Widget AirDropdownMenuOption() {
    return DropdownButton(
        value: selectAirOption,
        items: Airoption.map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: 16),
              ),
            )).toList(),
        onChanged: (item) => setState(() {
              selectAirOption = item;
            }));
  }

  Widget WeatherDropdownMenuOption() {
    return DropdownButton(
        value: selectWeatherOption,
        items: Weatheroption.map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: 16),
              ),
            )).toList(),
        onChanged: (item) => setState(() {
              selectWeatherOption = item;
            }));
  }

  Widget AirSetting() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.all(
            Radius.circular(10) //                 <--- border radius here
            ),
      ),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Air Quality",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            AirDropdownMenuOption(),
            Container(
                child: selectAirOption == 'PERIODIC'
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text("Frequency",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TextField(
                                    controller: Air_Controller,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0)),
                                  ),
                                ),
                              ),
                              Text("Hour")
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text("Time of the day",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${air_hour}:${air_minute}"),
                              ElevatedButton(
                                  onPressed: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                    );

                                    if (newTime == null) return;

                                    setState(() {
                                      air_hour = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      air_minute = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      air_time = newTime;
                                    });
                                  },
                                  child: Text("Select time"))
                            ],
                          ),
                        ],
                      )),
          ],
        ),
      ),
    );
  }

  Widget WeatherSetting() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.all(
            Radius.circular(10) //                 <--- border radius here
            ),
      ),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weather",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            WeatherDropdownMenuOption(),
            Container(
                child: selectWeatherOption == 'PERIODIC'
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text("Frequency",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TextField(
                                    controller: Weather_Controller,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0)),
                                  ),
                                ),
                              ),
                              Text("Hour")
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text("Time of the day",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${weather_hour}:${weather_minute}"),
                              ElevatedButton(
                                  onPressed: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                    );

                                    if (newTime == null) return;

                                    setState(() {
                                      weather_hour = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      weather_minute = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      time = newTime;
                                    });
                                  },
                                  child: Text("Select time"))
                            ],
                          ),
                        ],
                      )),
          ],
        ),
      ),
    );
  }

  Widget AddButton() {
    return FloatingActionButton(
        child: Text("Save"),
        onPressed: () {
          if (Exist == false) {
            if (selectWeatherOption == 'TIME_OF_DAY') {
              createWeatherReminder(
                  Id, selectWeatherOption, "${weather_hour}:${weather_minute}");
            }
            if (selectAirOption == 'TIME_OF_DAY') {
              createAirReminder(
                  Id, selectAirOption, "${air_hour}:${air_minute}");
            } else {
              createWeatherReminder(
                  Id, selectWeatherOption, Weather_Controller.text.toString());
              createAirReminder(
                  Id, selectAirOption, Air_Controller.text.toString());
            }
          } else {
            if (selectWeatherOption == 'TIME_OF_DAY') {
              updateWeatherReminder(_r[0], Id, selectWeatherOption,
                  "${weather_hour}:${weather_minute}");
            }
            if (selectAirOption == 'TIME_OF_DAY') {
              updateAirReminder(
                  _r[1], Id, selectAirOption, "${air_hour}:${air_minute}");
            } else {
              updateWeatherReminder(_r[0], Id, selectWeatherOption,
                  Weather_Controller.text.toString());
              updateAirReminder(
                  _r[1], Id, selectAirOption, Air_Controller.text.toString());
            }
          }
        });
  }
}

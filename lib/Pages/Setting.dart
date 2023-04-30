import 'package:flutter/material.dart';
import 'package:weather_station/Models/Weather.dart';
import 'package:weather_station/dialog/reminders_dialog.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay air_time = TimeOfDay.now();

  final Weather_Controller = TextEditingController();
  final Air_Controller = TextEditingController();

  print_data(){
    print("Weather");
    print("time of the day ${time.hour.toString().padLeft(2,"0")}:${time.minute.toString().padLeft(2,"0")}");
    print("frequency ${Weather_Controller.text}");
    print("Air quality");
    print("time of the day ${air_time.hour.toString().padLeft(2,"0")}:${air_time.minute.toString().padLeft(2,"0")}");
    print("frequency ${Air_Controller.text}");
  }
  @override
  Widget build(BuildContext context) {
    final weather_hour = time.hour.toString().padLeft(2,"0");
    final weather_minute = time.minute.toString().padLeft(2,"0");
    final air_hour = air_time.hour.toString().padLeft(2,"0");
    final air_minute = air_time.minute.toString().padLeft(2,"0");
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        margin: const EdgeInsets.only(
            top: 35, left: 15.0, bottom: 15.0, right: 15.0),
        child: Column(children: [
          Text("Setting",style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Container(
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
                  Text("Time of the day",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${weather_hour}:${weather_minute}"),
                      ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input,);

                            if (newTime == null) return;

                            setState(() {
                              time = newTime;
                            });
                          },
                          child: Text("Select time"))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Frequency",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
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
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
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
                  Text("Time of the day",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${air_hour}:${air_minute}"),
                      ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input,);

                            if (newTime == null) return;

                            setState(() {
                              air_time = newTime;
                            });
                          },
                          child: Text("Select time"))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Frequency",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
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
              ),
            ),
          ),
          // Card(
          //   child: SizedBox(
          //     width: double.infinity, height: 300, child: Container(
          //       child: Column(
          //         children: [
          //           Text("Time of the day"),
          //           Text("Fr")
          //         ],
          //       ),
          //     )),
          // ),
          // Card(
          //   child: SizedBox(
          //     width: double.infinity, height: 100, child: Text("Pm 2.5")),
          // )
        ]),
        // child: Row(
        //   children: [
        //     Expanded(
        //         child: ListView.builder(
        //             shrinkWrap: true,
        //             physics: ClampingScrollPhysics(),
        //             padding: const EdgeInsets.only(
        //                 left: 8, top: 0, bottom: 0, right: 8),
        //             itemCount: 5,
        //             itemBuilder: (BuildContext context, int index) {
        //               return Container(
        //                   padding: const EdgeInsets.only(
        //                       left: 10, top: 5, bottom: 5, right: 10),
        //                   margin: const EdgeInsets.all(5),
        //                   child: Row(children: [
        //                     Expanded(
        //                         child: Text(
        //                       "Date",
        //                       style: TextStyle(fontSize: 14, color: Colors.black),
        //                     )),
        //                     Expanded(child: Text("Icon")),
        //                     Expanded(
        //                         child: Text(
        //                       "$index/$index",
        //                       textAlign: TextAlign.right,
        //                       style: TextStyle(fontSize: 14, color: Colors.grey),
        //                     )),
        //                   ]));
        //             }))
        //   ],
        // ),
      ),
      floatingActionButton: AddButton(),
    );
  }

  Widget AddButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print_data();
        });
  }
}

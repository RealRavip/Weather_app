import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_station/Models/ReminderApi.dart';

updateWeatherReminder(
    ReminderApi _w, String? Id, String? option, String i) async {
  Map<String, String> requestHeaders = {
    'X-Device-ID': '${Id}',
  };
  final url = Uri.parse("http://192.168.1.48:8080/users/reminders");
  if (option == 'TIME_OF_DAY') {
    Map<String, dynamic> args = {
      "id": _w.id,
      "type": _w.type,
      "option": option,
      "timeOfDay": i
    };
    var body = json.encode(args);
    var response = await http.put(url, body: body, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
  }
  if (option == 'PERIODIC') {
    Map<String, dynamic> args = {
      "id": _w.id,
      "type": _w.type,
      "option": option,
      "periodicDuration": '${i}h'
    };
    var body = json.encode(args);
    var response = await http.put(url, body: body, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
  }
}
updateAirReminder(
    ReminderApi _w, String? Id, String? option, String i) async {
  Map<String, String> requestHeaders = {
    'X-Device-ID': '${Id}',
  };
  final url = Uri.parse("http://192.168.1.48:8080/users/reminders");
  if (option == 'TIME_OF_DAY') {
    Map<String, dynamic> args = {
      "id": _w.id,
      "type": _w.type,
      "option": option,
      "timeOfDay": i
    };
    var body = json.encode(args);
    var response = await http.put(url, body: body, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
  }
  if (option == 'PERIODIC') {
    Map<String, dynamic> args = {
      "id": _w.id,
      "type": _w.type,
      "option": option,
      "periodicDuration": '${i}h'
    };
    var body = json.encode(args);
    var response = await http.put(url, body: body, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
  }
}

sendFcmToken(String? Id, String fcm, double lat, double long) async {
  Map<String, String> requestHeaders = {
    'X-Device-ID': '${Id}',
    'X-Lat' : '${lat}',
    'X-Lon' : '${long}'
  };
  final url = Uri.parse("http://192.168.1.48:8080/users/fcm-token");
  Map<String, dynamic> args = {
      "fcmToken": fcm,
    };
    var body = json.encode(args);
    var response = await http.put(url, body: body, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
}
//   if(res.statusCode == 404){
//     List<int> purpose = [];
//   for (var i in global.record) {
//     if (i.primary == true) {
//       global.Action = "PARTIAL";
//       purpose.add(i.id);
//     }
//     if(i.primary == false){
//       global.Action = "NONE";
//     }
//   }
//   Map<String, dynamic> args = {
//     "consentId": _c.consentId.toString(),
//     "uid": global.uid,
//     "name": global.Name,
//     "consentVersion": _c.version,
//     "purposes": purpose,
//     "action": global.Action,
//     "language": "th",
//     "collectionChannel": "Mobile App"
//   };
//   var body = json.encode(args);
//   var response = await http
//       .post(url, body: body, headers: {'Content-type': 'application/json'});
//   print(response.statusCode);
//   print(response.body);
//   }
  
// }

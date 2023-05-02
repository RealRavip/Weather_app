
import 'dart:convert';

ReminderApi reminderApiFromJson(String str) =>
    ReminderApi.fromJson(json.decode(str));
class ReminderApi {
  String? id;
  String? userDeviceId;
  String? type;
  String? option;
  String? lastRemindedTime;
  String? remindAgainOn;
  String? periodicDuration;
  String? timeOfDay;

  ReminderApi(
      {this.id,
      this.userDeviceId,
      this.type,
      this.option,
      this.lastRemindedTime,
      this.remindAgainOn,
      this.periodicDuration,
      this.timeOfDay});

  ReminderApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userDeviceId = json['userDeviceId'];
    type = json['type'];
    option = json['option'];
    lastRemindedTime = json['lastRemindedTime'];
    remindAgainOn = json['remindAgainOn'];
    periodicDuration = json['periodicDuration'];
    timeOfDay = json['timeOfDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userDeviceId'] = this.userDeviceId;
    data['type'] = this.type;
    data['option'] = this.option;
    data['lastRemindedTime'] = this.lastRemindedTime;
    data['remindAgainOn'] = this.remindAgainOn;
    data['periodicDuration'] = this.periodicDuration;
    data['timeOfDay'] = this.timeOfDay;
    return data;
  }
}



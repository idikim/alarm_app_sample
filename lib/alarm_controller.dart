import 'package:alarm_app_sample/alarm_model.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController {
  int hour = 0;
  int minute = 0;

  bool isEditMode = false;

  List<AlarmModel> alarmList = [];

  void setHour(int hour) {
    this.hour = hour;
    update();
  }

  void setMinute(int minute) {
    this.minute = minute;
    update();
  }

  void saveAlarm({String? id}) {
    if (id != null) {
      final newAlarmList = alarmList.map((element) {
        if (element.id == id) {
          element.hour = hour;
          element.minute = minute;
        }
        return element;
      }).toList();
      alarmList = newAlarmList;
    } else {
      alarmList.add(AlarmModel(hour: hour, minute: minute));
    }

    update();
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    update();
  }

  void removeAlarm(String id) {
    alarmList.removeWhere((element) => element.id == id);
    update();
  }

  void editAlarm(AlarmModel alarm) {
    hour = alarm.hour;
    minute = alarm.minute;
  }
}

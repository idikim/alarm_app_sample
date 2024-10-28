import 'package:uuid/uuid.dart';

class AlarmModel {
  String id;
  int hour;
  int minute;
  bool isOn;

  AlarmModel({
    required this.hour,
    required this.minute,
    this.isOn = true,
  }) : id = Uuid().v4();
}

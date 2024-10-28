import 'package:alarm_app_sample/alarm_controller.dart';
import 'package:alarm_app_sample/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AlarmWritePage extends StatefulWidget {
  final AlarmModel? alarm;
  const AlarmWritePage({super.key, this.alarm});

  @override
  State<AlarmWritePage> createState() => _AlarmWritePageState();
}

class _AlarmWritePageState extends State<AlarmWritePage> {
  final hourController = TextEditingController();
  final minuteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.alarm != null) {
      hourController.text = widget.alarm!.hour.toString();
      minuteController.text = widget.alarm!.minute.toString();
      Get.find<AlarmController>().editAlarm(widget.alarm!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Text(
              '취소',
              style: TextStyle(
                color: Color(0xffff9f0a),
                fontSize: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(widget.alarm != null ? '알람 편집' : '알람 추가',
            style: TextStyle(color: Colors.white)),
        actions: [
          GestureDetector(
            onTap: () {
              Get.find<AlarmController>().saveAlarm(id: widget.alarm?.id);
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                '저장',
                style: TextStyle(
                  color: Color(0xffff9f0a),
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GetBuilder<AlarmController>(
              builder: (controller) {
                return Text(
                  controller.hour < 12 ? '오전' : '오후',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 28,
                    color: Color(0xffababac),
                  ),
                );
              },
            ),
            SizedBox(width: 15),
            SizedBox(
              width: 87,
              height: 87,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff2c2c2e),
                ),
                child: Center(
                  child: TextField(
                    controller: hourController,
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(1, 23),
                    ],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    onChanged: (String hour) {
                      if (hour == '') return;
                      Get.find<AlarmController>().setHour(int.parse(hour));
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            SizedBox(
              width: 87,
              height: 87,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff2c2c2e),
                ),
                child: Center(
                  child: TextField(
                    controller: minuteController,
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(0, 59),
                    ],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    onChanged: (String minute) {
                      if (minute == '') return;
                      Get.find<AlarmController>().setMinute(int.parse(minute));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }
    return newValue;
  }
}

import 'package:alarm_app_sample/alarm_controller.dart';
import 'package:alarm_app_sample/alarm_model.dart';
import 'package:alarm_app_sample/alarm_write_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _wakeUpAlarm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '알람',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(height: 15),
          Text(
            '🛌 수면 | 기상',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '알람없음',
                style: TextStyle(color: Color(0xff8d8d93), fontSize: 50),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff262629),
                ),
                child: Text(
                  '변경',
                  style: TextStyle(color: Color(0xffff9f0a), fontSize: 16),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _etcAlarm(AlarmModel alarm, bool isEditMode) {
    return GestureDetector(
      onTap: () {
        Get.to(AlarmWritePage(alarm: alarm));
      },
      child: Row(
        children: [
          if (isEditMode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  Get.find<AlarmController>().removeAlarm(alarm.id);
                },
                child: Icon(Icons.remove_circle, color: Colors.red),
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xff262629)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(alarm.hour < 12 ? '오전' : '오후',
                              style: TextStyle(
                                  fontSize: 25, color: Color(0xff8d8d93))),
                          SizedBox(width: 10),
                          Text(
                              '${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontSize: 60,
                                  color: Color(0xff8d8d93),
                                  height: 1,
                                  letterSpacing: -3))
                        ],
                      ),
                      Switch(
                        onChanged: (value) {
                          print(value);
                        },
                        value: alarm.isOn,
                      ),
                    ],
                  ),
                  Text('알람',
                      style: TextStyle(fontSize: 18, color: Color(0xff8d8d93))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: Get.find<AlarmController>().toggleEditMode,
          child: Center(
            child: GetBuilder<AlarmController>(
              builder: (controller) {
                return Text(
                  controller.isEditMode ? '완료' : '편집',
                  style: TextStyle(
                    color:
                        controller.isEditMode ? Color(0xffff9f0a) : Colors.red,
                    fontSize: 20,
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AlarmWritePage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset('assets/images/icon_add.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _wakeUpAlarm(),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '기타',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GetBuilder<AlarmController>(builder: (controller) {
              if (controller.alarmList.isEmpty) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text('등록된 알람이 없습니다.',
                      style: TextStyle(fontSize: 18, color: Color(0xff8d8d93))),
                );
              }
              return Column(
                children: controller.alarmList.map((alarm) {
                  return _etcAlarm(alarm, controller.isEditMode);
                }).toList(),
              );
            })
          ],
        ),
      ),
    );
  }
}

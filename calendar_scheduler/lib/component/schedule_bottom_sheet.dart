import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate; // 선택된 날짜 상위 위젯에서 입력받기

  const ScheduleBottomSheet({required this.selectedDate, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
        key: formKey,
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.only(
                  left: 8, right: 8, top: 8, bottom: bottomInset),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: '시작 시간',
                          isTime: true,
                          onSaved: (String? val) {
                            startTime = int.parse(val!);
                          },
                          validator: timeValidator,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: CustomTextField(
                          label: '종료 시간',
                          isTime: true,
                          onSaved: (String? val) {
                            endTime = int.parse(val!);
                          },
                          validator: timeValidator,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                      child: CustomTextField(
                    label: '내용',
                    isTime: false,
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: contentValidator,
                  )),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onSavePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: Text('저장'),
                    ),
                  ),
                ],
              )),
        )));
  }

  void onSavePressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save(); // 폼 저장하기

      await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          date: Value(widget.selectedDate),
        ),
      );

      Navigator.of(context).pop(); // 일정 생성 후 화면 뒤로 가기
    }
  }

  String? timeValidator(String? val) {
    if (val == null) {
      return 'please input time';
    }
    int? number;

    try {
      number = int.parse(val);
    } catch (e) {
      return 'please input number';
    }

    if (number < 0 || number > 24) {
      return 'please input number between 0 and 24';
    }

    return null;
  }

  String? contentValidator(String? val) {
    if (val == null || val.length == 0) {
      return 'please input content';
    }

    return null;
  }
}

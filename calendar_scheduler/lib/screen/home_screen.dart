import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:provider/provider.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();

    // 선택된 날짜 가져오기
    final selectedDate = provider.selectedDate;

    // 선택된 날짜에 해당되는 일정들 가져오기
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
        floatingActionButton: ClipOval(
          child: FloatingActionButton(
            backgroundColor: PRIMARY_COLOR,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isDismissible: true,
                builder: (_) => ScheduleBottomSheet(
                  selectedDate: selectedDate, // 선택된 날짜 (selectedDate) 넘겨주기
                ),
                isScrollControlled: true,
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기
              onDaySelected: onDaySelected, // 날짜가 선택됐을 때 실행할 함수
            ),
            SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDate: selectedDate, // 선택된 날짜
              count: schedules.length, // 선택된 날짜에 있는 일정들
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              // 남는 공간을 모두 차지하기
              child: StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // 데이터가 없을시
                    return Container();
                  }
                  // 화면에 보이는 값들만 렌더링하는 리스트
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final schedule = snapshot.data![index];
                      return Dismissible(
                        key: ObjectKey(schedule.id), // 유니크한 키값
                        // 밀기 방향(왼쪽에서 오른쪽으로)
                        direction: DismissDirection.startToEnd,
                        // 밀기 했을 때 실행할 함수
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
                        },
                        // 좌우로 패딩을 추가해서 UI 개선
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )));
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {}
}

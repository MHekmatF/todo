
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

import '../../auth/user_provider.dart';
import '../../firebase_utils.dart';

class TasksTap extends StatelessWidget {
  TasksTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).currentUser!.id;
    final tasksProvider = Provider.of<TasksProvider>(context)..getTasks(userId);

    // tasksProvider.getTasks();

    return Column(
      children: [
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              compactMode: true,
              weekDaySelectedColor: Theme.of(context).primaryColor,
              selectedBackgroundColor: Theme.of(context).primaryColor,
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: Theme.of(context).primaryColor,
              headerTextColor: Colors.black),
          dateTime: CalendarDateTime(
              year: tasksProvider.selectedDate.year,
              month: tasksProvider.selectedDate.month,
              day: tasksProvider.selectedDate.day),
          onChangeDateTime: (calenderDatetime) {
            tasksProvider.changeSelctedDate(
                userId, calenderDatetime.toDateTime());
          },
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return TaskItem(
                taskModel: tasksProvider.tasks[index],
              );
            }),
            itemCount: tasksProvider.tasks.length,
          ),
        )
      ],
    );
  }
}

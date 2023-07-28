import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderDatePickerWidget extends StatefulWidget {
  const CalenderDatePickerWidget({super.key});

  @override
  State<CalenderDatePickerWidget> createState() =>
      _CalenderDatePickerWidgetState();
}

class _CalenderDatePickerWidgetState extends State<CalenderDatePickerWidget> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker'),
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2000, 01, 01),
              lastDay: DateTime.utc(2100, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                setState(() {
                  //
                });
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                _calendarFormat = format;
                setState(() {
                  //
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: _selectedDay);
                  },
                  child: const Text('OK'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancle'),
                ),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
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
      // appBar: AppBar(
      //   title: const Text('Calender'),
      // ),
      body: TableCalendar(
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
        // eventLoader: (day) {
        //   return _getEventsForDay(day);
        // },
      ),
    );
  }

  // ----- Functions -----
  // List<Event> _getEventsForDay(DateTime day) {
  //   return 
  // }
}   // End
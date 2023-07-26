import 'dart:convert';

import 'package:http/http.dart' as http;
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
  late List todoList;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    todoList = [];
    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Calender'),
      // ),
      body: todoList.isEmpty
        ? const Center(
          child: Text('데이터가 비었습니다.'),
        )
        : TableCalendar(
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
      )
    );
  }

  // ---- Functions ----
  getTodoList() async {
    var url = Uri.parse('http://localhost:8080/Flutter/team4_todolist_select.jsp');
    var response = await http.get(url);
    print(response.body);
    todoList.clear(); // 화면에 데이터 정리. 안하면 쌓일 수 있음.
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes)); // 한국 사람은 이거 써야 됨.
    List result = dataConvertedJSON['results'];
    print(result);
    todoList.addAll(result);
    setState(() {
      //
    });
  } // getJSONData
}   // End
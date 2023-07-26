import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';

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

    List<dynamic> selectedDateEvents = getEventDataForSelectedDate(_selectedDay);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Calender'),
      // ),
      body: todoList.isEmpty
          ? const Center(
              child: Text('데이터가 비었습니다.'),
            )
          : Column(
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
                  // eventLoader: (day) {
                  //   return _getEventsForDay(day);
                  // },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "UserID's TodoList",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        itemCount: selectedDateEvents.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.defaultDialog(
                              title: "${selectedDateEvents[index]["t_title"]}",
                              middleText: "${selectedDateEvents[index]["t_content"]}",
                              backgroundColor: Colors.white,
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        selectedDateEvents[index]["t_title"],
                                        style: const TextStyle(
                                          fontSize: 25
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   selectedDateEvents[index]["t_content"],
                                  //   style: const TextStyle(
                                  //     fontSize: 15
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  // ---- Functions ----
  getTodoList() async {
    var url =
        Uri.parse('http://localhost:8080/Flutter/team4_todolist_select.jsp');
    var response = await http.get(url);
    // print(response.body);
    todoList.clear(); // 화면에 데이터 정리. 안하면 쌓일 수 있음.
    var dataConvertedJSON =
        json.decode(utf8.decode(response.bodyBytes)); // 한국 사람은 이거 써야 됨.
    List result = dataConvertedJSON['results'];
    // print(result);
    todoList.addAll(result);
    setState(() {
      //
    });
  } // getJSONData

  List<dynamic> getEventDataForSelectedDate(DateTime selectedDate) {
    return todoList.where((event) {
      DateTime eventDate = DateTime.parse(
          event['t_insertDate']); // JSON 데이터에 'date' 필드가 'yyyy-MM-dd' 형식으로 있다고 가정합니다.
      return eventDate.year == selectedDate.year &&
          eventDate.month == selectedDate.month &&
          eventDate.day == selectedDate.day;
    }).toList();
  }
}   // End
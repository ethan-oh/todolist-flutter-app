import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_four_todo_list_app/view/calender_detail.dart';

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
  late double _size;
  

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    todoList = [];
    getTodoList();
    _size = 0.4;

    // var result = Get.arguments ?? "";
  
  }

  @override
  Widget build(BuildContext context) {

    List<dynamic> selectedDateEvents =
        getEventDataForSelectedDate(_selectedDay);

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Calender'),
        // ),
        body: todoList.isEmpty
            ? const Center(
                child: Text('데이터가 비었습니다.'),
              )
            : SingleChildScrollView(
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
                        print(_calendarFormat);
                        _calendarFormat == CalendarFormat.twoWeeks
                        ? _size = 0.6
                        : _calendarFormat == CalendarFormat.week
                        ? _size = 0.8
                        : _size = 0.4;
                        setState(() {
                          //
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "UserID's TodoList",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${_selectedDay.toString().substring(0,10)} 일정 : ${selectedDateEvents.length}개'
                              ),
                              Text(
                                '/ 미완료(${countFalseStatus(selectedDateEvents)}/${selectedDateEvents.length}개)',
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                          selectedDateEvents.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: (MediaQuery.of(context).size.height - kToolbarHeight -
                                              MediaQuery.of(context).padding.top) * _size,
                                    child: ListView.builder(
                                      itemCount: selectedDateEvents.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(const DetailCalender(), arguments: [
                                            selectedDateEvents[index]["t_title"],
                                            selectedDateEvents[index]["t_content"],
                                            selectedDateEvents[index]["t_status"],
                                            selectedDateEvents[index]["t_insertDate"],
                                            selectedDateEvents[index]["t_no"],
                                            selectedDateEvents[index]["t_important"],
                                            selectedDateEvents[index]["t_startDate"],
                                            selectedDateEvents[index]["t_endDate"],
                                            ],
                                          )?.then((value) {
                                            if(value == "OK") {
                                              Get.snackbar(
                                                '수정 완료',
                                                '일정이 성공적으로 수정 되었습니다.',
                                                icon: const Icon(
                                                  Icons.access_alarm,
                                                  color: Colors.green,
                                                ),
                                                // backgroundColor: Colors.green,
                                              );
                                            }
                                            getTodoList();
                                          },);
                                          },
                                          child: SizedBox(
                                            height: 100,
                                            child: Dismissible(
                                              direction: DismissDirection.endToStart,
                                              key: ValueKey(selectedDateEvents[index]["t_no"]),
                                              onDismissed: (direction) {
                                                todoList.remove(selectedDateEvents[index]);
                                                deleteTodoList(selectedDateEvents[index]["t_no"]);
                                              },
                                              child: Card(
                                                color: Colors.white,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    if (selectedDateEvents[index]["t_status"])
                                                      Positioned(
                                                        left: 20.0,
                                                        child: Image.asset(
                                                          'images/good.png',
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                      ),
                                                    Text(
                                                      selectedDateEvents[index]["t_title"],
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    selectedDateEvents[index]["t_important"]
                                                      ? const Positioned(
                                                          right: 20.0,
                                                          child: Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      )
                                                      : const Positioned(
                                                          right: 20.0,
                                                          child: Icon(
                                                            Icons.star,
                                                            color: Colors.grey,
                                                          ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Center(
                                child: SizedBox(
                                  height: (MediaQuery.of(context).size.height -
                                            kToolbarHeight -
                                            MediaQuery.of(context)
                                                .padding
                                                .top) *
                                        0.20,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '일정이 없습니다.',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ---- Functions ----
  getTodoList() async {
    var url = Uri.parse('http://localhost:8080/Flutter/team4_todolist_select.jsp');
    var response = await http.get(url);
    // print(response.body);
    todoList.clear();
    var dataConvertedJSON =
        json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    // print(result);
    todoList.addAll(result);
    setState(() {
      //
    });
  } // getJSONData

  List<dynamic> getEventDataForSelectedDate(DateTime selectedDate) {
    return todoList.where((event) {
      DateTime eventDate = DateTime.parse(event['t_insertDate']);
      return eventDate.year == selectedDate.year &&
          eventDate.month == selectedDate.month &&
          eventDate.day == selectedDate.day;
    }).toList();
  }

  int countFalseStatus(List<dynamic> eventsList) {
  int count = 0;
  for (var event in eventsList) {
    bool status = event["t_status"];
    if (!status) {
      count++;
    }
  }
  return count;
}

    // ---- Functions ----
  deleteTodoList(int seqNo) async {
    var url = Uri.parse('http://localhost:8080/Flutter/team4_todolist_delete.jsp?t_no=${seqNo}');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];
    if(result == "OK") {
      Get.snackbar(
        '일정 삭제',
        '삭제가 완료 되었습니다.',
        icon: const Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
        // backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        '오류',
        '삭제가 중 문제가 발생했습니다.',
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
        ),
        // backgroundColor: Colors.red,
      );
    }
    getTodoList();
  } // 



  
}   // End
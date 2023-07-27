import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/foundation.dart';

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
  late bool isCompleted;
  late TextEditingController titleTec;
  late TextEditingController contentTec;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    todoList = [];
    isCompleted = false;
    titleTec = TextEditingController();
    contentTec = TextEditingController();
    getTodoList();
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
                          Text(
                            '${_selectedDay.toString().substring(0,10)} 일정 : ${selectedDateEvents.length}개'
                          ),
                          selectedDateEvents.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                kToolbarHeight -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
                                            0.20,
                                    child: ListView.builder(
                                      itemCount: selectedDateEvents.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => Get.bottomSheet(
                                            Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  mainAxisSize : MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      controller: titleTec,
                                                      decoration: const InputDecoration(
                                                        labelText: "제목",
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TextField(
                                                      controller: contentTec,
                                                      decoration: const InputDecoration(
                                                        labelText: "내용",
                                                      ),
                                                      minLines: 1,
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      '작성일자 : ${selectedDateEvents[index]["t_insertDate"].toString().substring(0, 10)}'
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          '완료 여부 :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Checkbox(
                                                          value: selectedDateEvents[index]["t_status"],
                                                          onChanged: (value) {
                                                            selectedDateEvents[index]["t_status"] = value;
                                                            setState(() {
                                                              //
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            //
                                                          },
                                                          child: const Text('수정'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text('닫기'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                                ],
                                              ),
                                            ),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            child: Card(
                                            color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  selectedDateEvents[index]["t_status"]
                                                  ?
                                                  Stack(
                                                    children: [
                                                      const CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                          'images/good.png',
                                                        ),
                                                        radius: 30,
                                                        backgroundColor: Colors.white,
                                                      ),
                                                      Text(
                                                        selectedDateEvents[index]["t_title"],
                                                        style: const TextStyle(
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  :
                                                  Row(
                                                    mainAxisAlignment : MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        selectedDateEvents[index]["t_title"],
                                                        style: const TextStyle(
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
      DateTime eventDate = DateTime.parse(event[
          't_insertDate']); // JSON 데이터에 'date' 필드가 'yyyy-MM-dd' 형식으로 있다고 가정합니다.
      return eventDate.year == selectedDate.year &&
          eventDate.month == selectedDate.month &&
          eventDate.day == selectedDate.day;
    }).toList();
  }

  updateStatus() {}
}   // End
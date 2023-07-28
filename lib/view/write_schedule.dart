import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:team_four_todo_list_app/view/calender.dart';
import 'package:team_four_todo_list_app/view/home.dart';

class WriteSchedule extends StatefulWidget {
  const WriteSchedule({super.key});

  @override
  State<WriteSchedule> createState() => _WriteScheduleState();
}

class _WriteScheduleState extends State<WriteSchedule> {
  // Property
  late TextEditingController titleController;
  late TextEditingController contentController;
  late DateTime startDateTime;
  late DateTime endDateTime;
  late bool important;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    startDateTime = DateTime.now();
    endDateTime = DateTime.now();
    important = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    hintText: '제목을 입력하세요',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('우선순위'),
                    IconButton(
                      onPressed: () {
                        important = !important;
                        setState(() {});
                      },
                      icon: Icon(
                        important ? Icons.star : Icons.star_border,
                        color: important ? Colors.amber : Colors.grey,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('시작 시간'),
                    CupertinoButton(
                      onPressed: () => _showDateTimeDialog(
                        CupertinoDatePicker(
                          initialDateTime: startDateTime,
                          use24hFormat: true,
                          // This is called when the user changes the dateTime.
                          onDateTimeChanged: (DateTime newDateTime) {
                            setState(() => startDateTime = newDateTime);
                          },
                        ),
                      ),
                      child: Text(
                          '${startDateTime.year}년 ${startDateTime.month.toString().padLeft(2, '0')}월 ${startDateTime.day.toString().padLeft(2, '0')}일 ${startDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('종료 시간'),
                    CupertinoButton(
                      onPressed: () => _showDateTimeDialog(
                        CupertinoDatePicker(
                          initialDateTime: endDateTime,
                          use24hFormat: true,
                          // This is called when the user changes the dateTime.
                          onDateTimeChanged: (DateTime newDateTime) {
                            setState(() => endDateTime = newDateTime);
                          },
                        ),
                      ),
                      child: Text(
                          '${endDateTime.year}년 ${endDateTime.month.toString().padLeft(2, '0')}월 ${endDateTime.day.toString().padLeft(2, '0')}일 ${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}'),
                    ),
                  ],
                ),
                TextField(
                  // 메모내용  ------------
                  controller: contentController,
                  maxLines: null,
                  minLines: 8,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요.',
                    labelText: '내용',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      insertTodoList();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    child: const Text('작성'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----  Functions -----
  _showDateTimeDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  insertTodoList() async {
    String result = 'OK';

    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty) {
      _showErrorDialog('모든 필드를 입력해주세요.');
    } else {
      var url = Uri.parse(
          'http://192.168.10.75:8080/Flutter/team4_todolist_insert.jsp?t_title=${titleController.text}&t_content=${contentController.text}&t_important=${important}&t_startDate=${startDateTime.toString().substring(0, 18)}&t_endDate=${endDateTime.toString().substring(0, 18)}');
      var response = await http.get(url);
      var dataConvertedJSON =
          json.decode(utf8.decode(response.bodyBytes)); // 한국 사람은 이거 써야 됨.
      result = dataConvertedJSON['result'];
      if (result == 'OK') {
        _showDialog();
      } else {
        _showErrorDialog('입력에 실패했습니다.');
      }
    }
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '입력 결과',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            '입력되었습니다.',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    titleController.text = '';
                    contentController.text = '';
                    startDateTime = DateTime.now();
                    endDateTime = DateTime.now();
                    important = false;
                    Get.back();
                    Get.offAll(const Home(), arguments: 0);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _showErrorDialog(String contentText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Error',
            textAlign: TextAlign.center,
          ),
          content: Text(
            contentText,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
} // End
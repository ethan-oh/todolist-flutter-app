import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:team_four_todo_list_app/view/widget/calender_datepicker_widget.dart';

class DetailCalender extends StatefulWidget {
  const DetailCalender({super.key});

  @override
  State<DetailCalender> createState() => _DetailCalenderState();
}

class _DetailCalenderState extends State<DetailCalender> {
    var value = Get.arguments ?? "";
    late TextEditingController titleTec;
    late TextEditingController contentTec;
    late bool isCompleted;
    late String date;
    late String startDate;
    late String endDate;
    late int t_no;
    late bool isImportant;

  @override
  void initState() {
    super.initState();
    titleTec = TextEditingController(text: value[0]);
    contentTec = TextEditingController(text: value[1]);
    isCompleted = value[2];
    date = value[3].toString().substring(0,10);
    t_no = value[4];
    isImportant = value[5];
    startDate = value[6] ?? "";
    endDate = value[7] ?? "";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('일정 보기'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                      border: OutlineInputBorder(),
                      labelText: "내용",
                    ),
                    minLines: 10,
                    maxLines: null,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(
                      '작성일자 : $date',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const CalenderDatePickerWidget())?.then((selectedDate) {
                              if (selectedDate != null) {
                                // 화면에서 선택한 날짜를 사용하여 필요한 작업을 수행합니다.
                                startDate = selectedDate.toString();
                                setState(() {
                                  //
                                });
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // 테두리 추가
                              borderRadius: BorderRadius.circular(8), // 버튼 모양을 위한 모서리 둥글게 설정
                            ),
                            child: Text(
                              startDate.isNotEmpty
                                ? "시작일자 : ${startDate.toString().substring(0, 10)}"
                                : "시작일자 : - ",
                              style: const TextStyle(
                                fontSize: 16,
                              ),  
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            Get.to(const CalenderDatePickerWidget())?.then((selectedDate) {
                              if (selectedDate != null) {
                                endDate = selectedDate.toString();
                                setState(() {
                                  //
                                });
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // 테두리 추가
                              borderRadius: BorderRadius.circular(8), // 버튼 모양을 위한 모서리 둥글게 설정
                            ),
                            child: Text(
                              endDate.isNotEmpty
                                ? "종료일자 : ${endDate.toString().substring(0, 10)}"
                                : "종료일자 : - ",
                              style: const TextStyle(
                                fontSize: 16,
                              ),  
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        '완료 여부 :',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      Checkbox(
                        value: isCompleted,
                        onChanged: (value) {
                          isCompleted = value!;
                          setState(() {
                            //
                          });
                        },
                      ),
                      const Text(
                        '중요 여부 :',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      Checkbox(
                        value: isImportant,
                        onChanged: (value) {
                          isImportant = value!;
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
                          fieldCheck();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('수정'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
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
    );
  }

  // ---- Functions ----
  updateTodoList() async {
    var url = Uri.parse('http://localhost:8080/Flutter/team4_todolist_update.jsp?t_title=${titleTec.text}&t_content=${contentTec.text}&t_status=${isCompleted}&t_no=${t_no}&t_important=${isImportant}&t_startDate=${startDate}&t_endDate=${endDate}');
    if((startDate.isNotEmpty && endDate.isEmpty) || (startDate.isEmpty && endDate.isNotEmpty)) {
      Get.snackbar(
        '경고',
        '날짜는 모두 지정해야 합니다.',
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.warning,
        ),
      );
      return;
    }
    print(startDate);
    print(endDate);
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes)); // 한국 사람은 이거 써야 됨.
    String result = dataConvertedJSON['result'];
    print(result);

    if(result == "OK") {
      Get.back(result: "OK");
    } else {
      if(value == "Fail") {
          Get.snackbar(
            'Error',
            '정보가 수정 중 오류가 발생했습니다..',
            icon: const Icon(
              Icons.warning,
              color: Colors.red,
            ),
            // backgroundColor: Colors.red,
          );
        }
    }
  } // 

  fieldCheck() async {
    if(titleTec.text.trim().isEmpty || contentTec.text.trim().isEmpty) {
      Get.snackbar(
        '경고',
        '공백은 입력 할 수 없습니다.',
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
        ),
        // backgroundColor: Colors.red,
      );
    } else {
      updateTodoList();
    }
  }

} // End

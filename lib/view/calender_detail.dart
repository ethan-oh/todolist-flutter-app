import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    late int t_no;

  @override
  void initState() {
    super.initState();
    titleTec = TextEditingController(text: value[0]);
    contentTec = TextEditingController(text: value[1]);
    isCompleted = value[2];
    date = value[3].toString().substring(0,10);
    t_no = value[4];
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
                  Text('작성일자 : $date'),
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
                        value: isCompleted,
                        onChanged: (value) {
                          isCompleted = value!;
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
    );
  }

  // ---- Functions ----
  updateTodoList() async {
    var url = Uri.parse('http://localhost:8080/Flutter/team4_todolist_update.jsp?t_title=${titleTec.text}&t_content=${contentTec.text}&t_status=${isCompleted}&t_no=${t_no}');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes)); // 한국 사람은 이거 써야 됨.
    String result = dataConvertedJSON['result'];

    if(result == "OK") {
      Get.back();
    } else {
      if(value == "Fail") {
          Get.snackbar(
            'Error',
            '정보가 수정 중 오류가 발생했습니다..',
            icon: const Icon(
              Icons.warning,
            ),
            backgroundColor: Colors.red,
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
        ),
        backgroundColor: Colors.red,
      );
    } else {
      updateTodoList();
    }
  }

} // End

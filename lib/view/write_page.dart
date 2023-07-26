import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  // Property
  late TextEditingController titleController;
  late TextEditingController contentController;
  late String labelName;
  late Color labelColor;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    labelName = LabelColors.colorLabels.keys.first;
    labelColor = Color(LabelColors.colorLabels[labelName]);
    isSelected = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: labelColor,
          centerTitle: true,
          title: ToggleButtons(
            onPressed: (int index) {
              // 버튼을 누르면 해당 버튼의 isSelected 값을 토글
              isSelected[index] = !isSelected[index];

              // 두 버튼 중 하나가 선택되면 다른 버튼의 선택 상태를 해제
              if (isSelected[0] && isSelected[1]) {
                isSelected[1 - index] = false;
              }
              setState(() {});
            },
            isSelected: isSelected,
            children: const [
              // 첫 번째 버튼
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.today_sharp,
                      ),
                    ),
                    Text('일정'),
                  ],
                ),
              ),
              // 두 번째 버튼
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.note_outlined,
                      ),
                    ),
                    Text('메모'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextField(
                  //   // 메모제목  ------------
                  //   controller: titleController,
                  //   maxLength: 30,
                  //   decoration: const InputDecoration(
                  //     hintText: '제목을 입력하세요.',
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () => _showBottomSheet(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // 라벨 색상 선택 ------------
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.color_lens_outlined,
                                ),
                              ),
                              Icon(
                                Icons.rectangle,
                                color: labelColor,
                              ),
                              Text('   $labelName'),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    // 메모내용  ------------
                    controller: contentController,
                    maxLines: null,
                    minLines: 12,
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
                        _emptyCheck();
                        _showDialog('입력 결과', '입력되었습니다.');
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
      ),
    );
  }

  // ----- Functions -----

  _emptyCheck() {
    if (contentController.text.trim().isEmpty) {
      _showDialog('ERROR', '내용이 입력되지 않았습니다.');
    } else {
      FirebaseFirestore.instance.collection('memo').add({
        'content': contentController.text.trim(),
        'labelcolor': labelName,
        'insertdate': DateTime.now()
      });
    }
  }

  _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    contentController.text = '';
                    labelName = LabelColors.colorLabels.keys.first;
                    labelColor = Color(LabelColors.colorLabels[labelName]);
                    Navigator.of(context).pop();
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

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  // bottomSheet 제목
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '라벨 색상 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                for (var entry in LabelColors.colorLabels.entries) // 라벨색상 반복
                  ListTile(
                    leading: Icon(
                      Icons.rectangle,
                      color: Color(entry.value),
                    ),
                    title: Text(
                      entry.key,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      labelColor = Color(entry.value);
                      labelName = entry.key;
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
} // End
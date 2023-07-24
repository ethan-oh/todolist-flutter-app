import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/model/memo/memo.dart';

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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    labelName = LabelColors.colorLabels.keys.first;
    labelColor = Color(LabelColors.colorLabels[labelName]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    // 메모제목  ------------
                    controller: titleController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      hintText: '제목',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () => _showBottomSheet(context),
                      child: Row(
                        // 라벨 색상 선택 ------------
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.color_lens_outlined,
                            ),
                          ),
                          SizedBox(
                            width: 280,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.rectangle,
                                  color: labelColor,
                                ),
                                Text('   $labelName'),
                              ],
                            ),
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
                    minLines: 15,
                    decoration: const InputDecoration(
                      hintText: '내용',
                      labelText: '내용을 입력하세요',
                      labelStyle: TextStyle(),
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _emptyCheck(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ----- Functions -----

  _emptyCheck() {
    if (titleController.text.trim().isEmpty) {
      _showDialog('ERROR', '제목이 입력되지 않았습니다.');
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
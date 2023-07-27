import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    startDateTime = DateTime.now();
    endDateTime = DateTime.now();
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
                      child: Text('${startDateTime.year}년 ${startDateTime.month}월 ${startDateTime.day}일 ${startDateTime.hour}:${endDateTime.minute}'),
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
                      child: Text('${endDateTime.year}년 ${endDateTime.month}월 ${endDateTime.day}일 ${endDateTime.hour}:${endDateTime.minute}'),
                    ),
                  ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----  Functions -----
  _showDateTimeDialog(Widget child){
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

} // End
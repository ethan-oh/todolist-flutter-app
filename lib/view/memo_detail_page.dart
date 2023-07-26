import 'package:flutter/material.dart';

class MemoDetailPage extends StatefulWidget {
  final List data;
  final int memoColor;
  const MemoDetailPage({super.key, required this.data, required this.memoColor});

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  late TextEditingController memoController;
  late List memoData;

  @override
  void initState() {
    super.initState();
    memoData = [];
    memoData.addAll(widget.data);
    memoController = TextEditingController(text: memoData[0]['title']);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 450,
                color: Color(widget.memoColor),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      readOnly: true,
                      controller: memoController,
                      maxLines: null,
                      minLines: 12,
                      decoration: const InputDecoration(
                        labelText: 'Memo',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MemoDetailWidget extends StatelessWidget {
  const MemoDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MemoProvider memoProvider = MemoProvider();
    TextEditingController memoController = TextEditingController(text: memoProvider.memoData[0]['title']);
    // late List memoData;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 450,
              color: Color(LabelColors.colorLabels[memoProvider.labelColor]),
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
    );
  }
}
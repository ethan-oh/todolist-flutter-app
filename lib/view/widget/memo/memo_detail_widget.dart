import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MemoDetailWidget extends StatelessWidget {
  const MemoDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MemoProvider memoProvider = MemoProvider();
    memoProvider = Provider.of<MemoProvider>(context, listen: false);
    TextEditingController memoController = TextEditingController(text: memoProvider.content);
    // late List memoData;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Consumer<MemoProvider>(
              builder: (context, value, child) {
                return Container(
                  height: 450,
                  color: Color(LabelColors.colorLabels[value.color]),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MemoDetailWidget extends StatelessWidget {
  const MemoDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _memoProvider = Provider.of<MemoProvider>(context, listen: false);
    TextEditingController memoController = TextEditingController(text: _memoProvider.memoData.contentText);

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Consumer<MemoProvider>(
              builder: (context, value, child) {
                // print('text = ${_memoProvider.memoData.contentText}');
                // print('text = ${value.memoData.contentText}');
                return Container(
                  height: 500,
                  color: Color(LabelColors.colorLabels[value.memoData.memoLabelColor]),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 350,
                      height: 450,
                      child: TextField(
                        controller: memoController,
                        // readOnly: true,
                        maxLines: null,
                        minLines: 18,
                        decoration: InputDecoration(
                          labelText: 'Memo',
                          filled: true,
                          fillColor: Color(LabelColors.colorLabels[value.memoData.memoLabelColor]),
                          border: const OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always
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
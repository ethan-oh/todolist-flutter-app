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
    TextEditingController memoDateController = TextEditingController(text: _memoProvider.memoData.insertdate! + "분");

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Consumer<MemoProvider>(
              builder: (context, value, child) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    color: Color(LabelColors.colorLabels[value.memoData.memoLabelColor]),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.93,
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: TextField(
                              controller: memoController,
                              // readOnly: true,
                              maxLines: null,
                              minLines: 16,
                              keyboardType: TextInputType.text,
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
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          controller: memoDateController,
                          readOnly: true,
                          maxLines: 1,
                          minLines: 1,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: '메모 생성 날짜',
                            filled: true,
                            fillColor: Color(LabelColors.colorLabels[value.memoData.memoLabelColor]),
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      )
                    ],
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
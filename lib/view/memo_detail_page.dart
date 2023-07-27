import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/view/widget/memo/memo_detail_widget.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 보기'),
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.save_as_rounded),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      body: const MemoDetailWidget(),
    );
  }
}
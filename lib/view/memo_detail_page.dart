import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/view/widget/memo/memo_detail_widget.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MemoDetailWidget(),
    );
  }
}
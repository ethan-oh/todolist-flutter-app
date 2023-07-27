import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/view/widget/home_drawer.dart';
import 'package:team_four_todo_list_app/view/widget/memo/memo_main_widget.dart';

class MeMoPage extends StatelessWidget {
  const MeMoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 메모'),
      ),
      drawer: const HomeDrawer(),
      body: const MemoMainWidget(),
    );
  }
}
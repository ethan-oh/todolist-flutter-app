import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_four_todo_list_app/view/widget/memo/memo_main_widget.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MeMoPage extends StatelessWidget {
  const MeMoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => MemoProvider(),
        child: const MemoMainWidget(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/view/widget/home_drawer.dart';
import 'package:team_four_todo_list_app/view/write_memo.dart';
import 'package:team_four_todo_list_app/view/write_schedule.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage>
    with SingleTickerProviderStateMixin {
  late TabController _WriteController;

  @override
  void initState() {
    super.initState();
    _WriteController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _WriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('작성하기'),
        centerTitle: true,
        bottom: TabBar(
          controller: _WriteController,
          labelColor: Colors.green,
          tabs: const [
            Tab(
              text: '일정',
            ),
            Tab(
              text: '메모',
            ),
          ],
        ),
      ),
      drawer: const HomeDrawer(),
      body: TabBarView(
        controller: _WriteController,
        children: const [
          WriteSchedule(),
          WriteMemo(),
        ],
      ),
    );
  }
}

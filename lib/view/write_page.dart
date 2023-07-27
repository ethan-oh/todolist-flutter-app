import 'package:flutter/material.dart';
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
        title: TabBar(
          controller: _WriteController,
          labelColor: Colors.green,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.today_outlined,
              ),
              text: '일정',
            ),
            Tab(
              icon: Icon(
                Icons.note_outlined,
              ),
              text: '메모',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _WriteController,
        children: const[
          WriteSchedule(),
          WriteMemo(),
        ],
      ),
    );
  }
}

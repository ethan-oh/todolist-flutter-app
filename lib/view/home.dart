import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/view/calender.dart';
import 'package:team_four_todo_list_app/view/memo_page.dart';
import 'package:team_four_todo_list_app/view/search_page.dart';
import 'package:team_four_todo_list_app/view/widget/home_drawer.dart';
import 'package:team_four_todo_list_app/view/write_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  // Property
  late TabController _tabController;
  late bool _login;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _login = false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          Calender(),   // 일정 Page 
          MeMoPage(),   // 메모 Page
          WritePage(),   // 작성 Page
          SearchPage(),   // 검색 Page
          Calender(),   // 설정 Page
        ],
      ),
      bottomNavigationBar: TabBar(
        labelColor: Colors.green,
        controller: _tabController,
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
          Tab(
            icon: Icon(
              Icons.add_circle,
              color: Colors.green,
            ),
            text: '작성',
          ),
          Tab(
            icon: Icon(
              Icons.search_rounded,
            ),
            text: '검색',
          ),
          Tab(
            icon: Icon(
              Icons.settings,
            ),
            text: '설정',
          ),
        ],
      ),
    );
  }
}
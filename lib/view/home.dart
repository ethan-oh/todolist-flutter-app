import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/view/calender.dart';
import 'package:team_four_todo_list_app/view/memo_page.dart';
import 'package:team_four_todo_list_app/view/search_page.dart';
import 'package:team_four_todo_list_app/view/write_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  // Property
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // // 리스트 뷰 상단 시계부분에 적용되는 패딩 제거.
          children:  [
            const UserAccountsDrawerHeader( // drawer의 유저 위젯
              accountName: Text('오성민'), 
              accountEmail: Text('osm6227@gmail.com'),
              currentAccountPicture: Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar( // user image
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green, // 헤더 배경색
                borderRadius: BorderRadius.only( // 헤더 테두리 라운딩
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            ListTile( // drawer의 리스트타일
              leading: const Icon( // 타일의 리딩 아이콘
                Icons.mail,
                color: Colors.blue,
              ),
              title: const Text(''),
              onTap: () => Navigator.pushNamed(context, '/'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Calender(),   // 일정 Page 
          Calender(),   // 일정 Page 
          // MeMoPage(),   // 메모 Page
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
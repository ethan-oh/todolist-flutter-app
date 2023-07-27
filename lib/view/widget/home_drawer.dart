import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          ListTile( // drawer의 리스트타일
            leading: const Icon( // 타일의 리딩 아이콘
              Icons.person,
              color: Colors.blue,
            ),
            title: const Text('회원가입'),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
    );
  }
}
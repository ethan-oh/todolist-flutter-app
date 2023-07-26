import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:team_four_todo_list_app/view/join_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver{

   late AppLifecycleState _lastLifeCycleState;

  late TextEditingController userIdController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userIdController = TextEditingController();
    passwordController = TextEditingController();
    _initSharedpreferences();
  }

  @override
  void dispose() {
    _disposeSharedPreferences();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state){
      case AppLifecycleState.detached:
      print('detached');
      break;
      case AppLifecycleState.resumed:
      print('resumed');
      break;
      case AppLifecycleState.inactive:
      _disposeSharedPreferences();
      print('inactive');
      break;
      case AppLifecycleState.paused:
      print('paused');
      break;
    }
    _lastLifeCycleState = state;
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: userIdController,
            ),
            TextField(
              controller: passwordController,
            ),
            ElevatedButton(
              onPressed: ()  {
                // Get.to(const Calender); 작성페이지 이동 변경 필요
                Get.snackbar(
                  "Snack Bar",
                  'Message',
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.teal,
                );
              },
              child: const Text('로그인'),),
            ElevatedButton(
              onPressed: () {
                Get.to(const JoinPage());

                Get.snackbar(
                  "Snack Bar",
                  'Message',
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.teal,
                );
              }, 
              child: const Text('회원가입'),),
          ],
        ),
      ),
      
    );
  }


_initSharedpreferences()async{
  final prefs = await SharedPreferences.getInstance();
  userIdController.text = prefs.getString('p_userId') ?? "";
  passwordController.text = prefs.getString('p_password') ?? "";

  //앱을 종료하고 다시 실행하면 SharedPreferences에 남아 있으므로 앱을 종료시 정리해야한다.
  print(userIdController);
  print(passwordController);
}

_saveSharedPreferences() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('p_userId', userIdController.text);
  prefs.setString('p_password', passwordController.text);
}


_disposeSharedPreferences() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.clear(); 
}


}//end
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:team_four_todo_list_app/model/memo/customer.dart';
import 'package:team_four_todo_list_app/model/memo/message.dart';
import 'package:team_four_todo_list_app/view/join_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  //  late AppLifecycleState _lastLifeCycleState;

  late TextEditingController userIdController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userIdController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
                controller: userIdController,
                decoration: const InputDecoration(
                    labelText: '아이디를 입력해주세요', hintText: '영어와 숫자만 입력하세요'),
              ),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호 입력해주세요',
                  hintText: '영어와 숫자만 입력하세요',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(const Calender); <- 작성페이지 이름 변경 필요
                    if (userIdController.text.trim().isEmpty) {
                      // 유저 아이디 필드가 비어있을 경우
                      Get.snackbar(
                        '빈칸을 채워주세요',
                        '아이디를 입력해주세요',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.teal,
                      );
                    } else if (passwordController.text.trim().isEmpty) {
                      // 비밀번호 필드가 비어있을 경우
                      Get.snackbar(
                        '빈칸을 채워주세요',
                        '비밀번호를 입력해주세요',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.teal,
                      );
                    } else {
                      //Get.to('페이지'), 작성페이지 써야함
                    }
                  },
                  child: const Text('로그인'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(JoinPage());
                },
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



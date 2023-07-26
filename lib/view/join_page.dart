import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  late TextEditingController userIdController;    // 아이디
  late TextEditingController passwordController;  // 비밀번호
  late TextEditingController password2Controller; //2차 비밀번호 중복확인
  late TextEditingController addressController;    //주소
  late TextEditingController phoneController;  //핸드폰번호
  late TextEditingController emailController;    //이메일

  @override
  void initState() {
  super.initState();
  userIdController = TextEditingController();
  passwordController = TextEditingController();
  password2Controller = TextEditingController();
  addressController = TextEditingController();
  phoneController = TextEditingController();
  emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: '성명을 입력해주세요'
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호를 입력해주세요'
              ),
            ),
            TextField(
              controller: password2Controller,
              decoration: InputDecoration(
                labelText: '다시 한번 비밀번호를 입력해주세요'
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: '주소를 입력해주세요'
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: '전화번호를 입력해주세요'
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: '이메일을 입력해주세요'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              }, 
              child: const Text('회원가입'))
          ],
        ),
      ),
    );
  }
}
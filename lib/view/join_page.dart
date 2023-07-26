import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';

class JoinPage extends StatefulWidget {
  // final SignUpController signUpController = Get.put(SignUpController());

  JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  late TextEditingController userIdController; // 아이디
  late TextEditingController passwordController; // 비밀번호
  late TextEditingController password2Controller; //2차 비밀번호 중복확인
  late TextEditingController addressController; //주소
  late TextEditingController phoneController; //핸드폰번호
  late TextEditingController emailController; //이메일

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
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                inputFormatters: <TextInputFormatter>[
                  //한글을 제외한 영어 대,소문자,숫자 입력 가능
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
                controller: userIdController,
                decoration: const InputDecoration(
                  labelText: '아이디을 입력해주세요',
                ),
              ),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  //특수문자를 제외한 문자,숫자 입력 가능
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9가-힣]')),
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {},
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호를 입력해주세요',
                ),
              ),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  //특수문자를 제외한 문자,숫자 입력 가능
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9가-힣]'),),
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: password2Controller,
                decoration: InputDecoration(labelText: '다시 한번 비밀번호를 입력해주세요'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: '주소를 입력해주세요'),
              ),
              TextField(
                controller: phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  LengthLimitingTextInputFormatter(13),
                ],
                onChanged: (value) {
                  final RegExp phoneRegex =
                      RegExp(r'^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$');
                  if (phoneRegex.hasMatch(value)) {
                  } else {}
                },
                decoration: InputDecoration(
                  labelText: '전화번호를 입력해주세요',
                ),
              ),
              TextField(
                controller: emailController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
                ],
                decoration: InputDecoration(
                  labelText: '이메일',
                ),
                onChanged: (value) {
                  final RegExp emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
                  if (emailRegex.hasMatch(value)) {
                  } else {
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      //텍스트 필드 미입력시 팝업
                      onPressed: () {
                        if (userIdController.text.trim().isEmpty) {
                          Get.snackbar(
                            '알림',
                            '아이디를 입력해주세요.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (passwordController.text.trim().isEmpty) {
                          Get.snackbar(
                            '알림',
                            '패스워드를 입력해주세요.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (password2Controller.text.trim().isEmpty) {
                          Get.snackbar(
                            '알림',
                            '재비밀번호를 입력해주세요.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (addressController.text.trim().isEmpty) {
                          Get.snackbar(
                            '알림',
                            '주소를 입력해주세요.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (phoneController.text.trim().isEmpty) {
                          Get.snackbar(
                            '알림',
                            '전화번호를 입력해주세요.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (emailController.text.trim().isEmpty) {
                          Get.snackbar(
                            '알림',
                            '이메일를 입력해주세요.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          // 이전 화면으로 돌아가기
                          Get.back();
                        }
                      },
                      child: const Text('회원가입'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child:const Text('취소하기')),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
                
            ],
          ),
        ),
      ),
    );
  }

  // FirebaseFirestore.instance.collection('customer').add({
  //                 'id': userIdController.text,
  //                 'password': passwordController.text,
  //                 'password2': password2Controller.text,
  //                 'address': addressController.text,
  //                 'phone': phoneController.text,
  //                 'email': emailController.text,
  //               });
}

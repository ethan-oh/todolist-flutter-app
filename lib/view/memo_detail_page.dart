import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/model/memo/memo.dart';
import 'package:team_four_todo_list_app/view/widget/memo/memo_detail_widget.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _memoProvider = Provider.of<MemoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 보기'),
        actions: [
          IconButton(
            onPressed: () => _showBottomSheet(context, _memoProvider),
            icon: const Icon(Icons.palette_outlined),
          ),
          IconButton(
            onPressed: () {
              // print(_memoProvider.content);
              FirebaseFirestore.instance.collection('memo').doc(_memoProvider.id).update({'content' : _memoProvider.content, 'labelcolor' : _memoProvider.color});
              Get.back();
              Get.snackbar('메모', '메모 내용이 변경 되었습니다.', snackPosition: SnackPosition.BOTTOM);
            },
            icon: const Icon(Icons.save_as_rounded),
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: '삭제',
                middleText: '정말 삭제하시겠습니까?',
                onCancel: () => Get.back(),
                onConfirm: () async {
                  await FirebaseFirestore.instance.collection('memo').doc(_memoProvider.id).delete();
                  Get.back();
                  Get.back();
                  await Get.snackbar('메모', '메모가 삭제 되었습니다.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Color(LabelColors.colorLabels[_memoProvider.memoData.memoLabelColor]));
                },
              );
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      body: const MemoDetailWidget(),
    );
  }

  _showBottomSheet(BuildContext context, MemoProvider memoProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  // bottomSheet 제목
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '라벨 색상 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                for (var entry in LabelColors.colorLabels.entries) // 라벨색상 반복
                  ListTile(
                    leading: Icon(
                      Icons.rectangle,
                      color: Color(entry.value),
                    ),
                    title: Text(
                      entry.key.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      memoProvider.addColor(entry.key);
                      Get.back();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
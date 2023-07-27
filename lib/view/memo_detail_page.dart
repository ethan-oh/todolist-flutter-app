import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
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
            onPressed: () {
              //FirebaseFirestore.instance.collection('memo').doc(_memoProvider.id).update({'content' : });
            },
            icon: const Icon(Icons.save_as_rounded),
          ),
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('memo').doc(_memoProvider.id).delete();
              Get.back();
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      body: const MemoDetailWidget(),
    );
  }
}
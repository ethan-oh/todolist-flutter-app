import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/model/memo/memo.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MemoMainWidget extends StatelessWidget {
  const MemoMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MemoProvider memoProvider = MemoProvider();
    memoProvider = Provider.of<MemoProvider>(context, listen: false);

    return Consumer<MemoProvider>(
      builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('memo').orderBy('insertdate', descending: true).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading...')
                  ],
                ),
              );
            }
            final documnets = snapshot.data!.docs;
            return ListView(
              children: documnets.map((e) => _buildItemWidget(e)).toList(),
            );
          }
        );
      },
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc){
    final memoData = Memo(
      contentText: doc['content'],
      memoLabelColor: doc['labelcolor'],
    );
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_forever),
      ),
      key: ValueKey(doc),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection('memo').doc(doc.id).delete();
      },
      child: Card(
        color: Color(LabelColors.colorLabels[memoData.memoLabelColor]),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    child: Text(
                      memoData.contentText,
                      style: const TextStyle(
                        fontSize: 25
                      ),
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
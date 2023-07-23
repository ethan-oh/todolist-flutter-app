import 'dart:math';

import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/get_json.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/view/memo_detail_page.dart';

class MeMoPage extends StatefulWidget {
  const MeMoPage({super.key});

  @override
  State<MeMoPage> createState() => _MeMoPageState();
}

class _MeMoPageState extends State<MeMoPage> {
  late List memoData;

  @override
  void initState() {
    super.initState();
    memoData = [];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          memoData.isEmpty
          ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('Loading...')
              ],
            ),
          )
          : ListView.builder(
            itemCount: memoData.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: ValueKey(memoData[index]['userId']),
                background: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 50,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MemoDetailPage(data: memoData,
                          memoColor: LabelColors.colorLabels.values.elementAt(
                            index >= LabelColors.colorLabels.length ? index - LabelColors.colorLabels.length : index));
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: Color(
                      LabelColors.colorLabels.values.elementAt(
                        index >= LabelColors.colorLabels.length 
                        ? index - LabelColors.colorLabels.length 
                        : index)
                    ),  //LabelColors.colorLabels['pastelYellow1']),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 350,
                                child: Text(
                                  memoData[index]['title'],
                                  style: const TextStyle(
                                    fontSize: 25
                                  ),
                                )
                              ),
                            ),
                          ],
                        ),
                        //Text(memoData[index]['body']),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  getData() async {
    memoData.addAll(await getJSONData('https://jsonplaceholder.typicode.com/posts'));   // Test 주소
    print(memoData.length);
    setState(() {
      
    });
  }
}
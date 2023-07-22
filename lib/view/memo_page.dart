import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/get_json.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';

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
      body: memoData.isEmpty
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
            return Card(
              color: Color(LabelColors.colorLabels['pastelYellow1']),
              child: Column(
                children: [
                  Text(memoData[index]['userId'].toString()),
                  Text(memoData[index]['id'].toString()),
                  Text(memoData[index]['title'].toString()),
                  Text(memoData[index]['body'].toString()),
                ],
              ),
            );
          },
        ),
    );
  }


  getData() async {
    memoData.addAll(await getJSONData('https://jsonplaceholder.typicode.com/posts'));   // Test 주소
    print(memoData.length);
  }
}
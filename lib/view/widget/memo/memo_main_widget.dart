import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/get_json.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/view/memo_detail_page.dart';
import 'package:team_four_todo_list_app/viewmodel/memo/memo_provider.dart';

class MemoMainWidget extends StatelessWidget {
  const MemoMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MemoProvider memoProvider = MemoProvider();
    List memoData = [];
    int count = 0;
    getData();

    return Stack(
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
                        memoProvider.addList(memoData[index], LabelColors.colorLabels.keys.elementAt(
                          count >= LabelColors.colorLabels.length - 1 ? count = 0 : count++));
                        return const MemoDetailPage();
                      },
                    ),
                  );
                },
                child: Card(
                  color: Color(
                    LabelColors.colorLabels.values.elementAt(
                      count >= LabelColors.colorLabels.length -1
                      ? count = 0
                      : count++)
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
    );
  }

  getData() async {
    List data = await getJSONData('https://jsonplaceholder.typicode.com/posts');   // Test 주소
    print(data.length);
    return data;
  }
}
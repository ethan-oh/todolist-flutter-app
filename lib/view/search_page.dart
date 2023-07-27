import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_four_todo_list_app/functions/label_color.dart';
import 'package:team_four_todo_list_app/model/search/search_fb.dart';
import 'package:team_four_todo_list_app/model/search/search_sql.dart';
import 'package:team_four_todo_list_app/model/search/search_sqldb.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late List memoData;
  DatabaseHandler handler = DatabaseHandler();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    memoData = [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          title: Column(
            children: [
              const Text('Search'),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (searchController.text.trim().isEmpty) {
                        Get.snackbar(
                          'Error',
                          '검색할 내용을 입력해주세요',
                          snackPosition: SnackPosition.BOTTOM, // 스낵바 위치
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        );
                      }
                      addScearch();
                      setState(() {});
                    },
                    child: const Icon(Icons.search),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const Row(
                children: [
                  Text(
                    '최근 검색어',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: handler.querySearch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: 500,
                          height: 50,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 0), // 구분자 설정
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return TextButton(
                                  onPressed: () {
                                    searchController.text = snapshot.data![index].content;
                                  },
                                  child: Row(
                                    children: [
                                      Text(snapshot.data![index].content
                                          .toString()),
                                      IconButton(
                                          onPressed: () {
                                            handler.deleteStudents(
                                                snapshot.data![index].seq!);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 15,
                                          )),
                                    ],
                                  ));
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Text("");
                    }
                  }),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('memo').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data!.docs; // docs <- document
            return searchController.text.trim().isNotEmpty
                ? ListView(
                    children:
                        documents.map((e) => _buildItemWidget(e)).toList(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('검색어를 입력해주세요.'),
                        SizedBox(
                          width: 150,
                          child: Image.network(
                            'https://www.hushwish.com/wp-content/uploads/2018/11/emo_cashbee_012.gif',
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  // functions
  Widget _buildItemWidget(DocumentSnapshot doc) {
    var memoData = SearchFB(
        insertDate: doc['insertdate'],
        labelColor: doc['labelcolor'],
        content: doc['content']);
    return memoData.content.contains(searchController.text)
        ? Card(
            color: Color(LabelColors.colorLabels[memoData.labelColor]),
            child: ListTile(title: Text(memoData.content)),
          )
        : const SizedBox(
            width: 0,
          );
  }

  Future<int> addScearch() async {
    SearchSql firstSearch = SearchSql(
      content: searchController.text,
    );
    await handler.insertSearch(firstSearch);
    return 0;
  }
} // end

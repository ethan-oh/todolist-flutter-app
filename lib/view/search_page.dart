import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/model/search_fb.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late List memoData;
  late List searchData;
  late int conut;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    memoData = [];
    searchData = [];
    conut = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            const Text('Search'),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                onTap: () {
                  if(searchController.text.trim().isNotEmpty){
                    
                  }
                },
                child: const Icon(Icons.search),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
                .collection('memo')
                .where('content', arrayContains: '메모 테스트')
                .orderBy('insertdate',descending: false)
                .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;          // docs <- document
          return ListView(
            children: documents.map((e) => _buildItemWidget(e)).toList(),
          );
        },
      ),
    );
  }

  // functions
  Widget _buildItemWidget(DocumentSnapshot doc){
    var memoList = SearchFB(insertDate: doc['insertdate'], labelColor: doc['labelcolor'], title: doc['content']);
    return Card(
      child: ListTile(
        title: Text(
          memoList.title
        ),
      ),
    );
  }


} // end

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
                  if(searchController.text.trim().isEmpty){
                    
                  }
                  setState(() {
                    
                  });
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
                .where('content', isGreaterThanOrEqualTo: searchController.text)
                .where('content', isLessThanOrEqualTo: '${searchController.text}\uf8ff')    
                .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;          // docs <- document
          return searchController.text.trim().isNotEmpty ? 
          ListView(
            children: documents.map((e) => _buildItemWidget(e)).toList(),
          ) :
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text(
                    '데이터 없다.'
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  // functions
  Widget _buildItemWidget(DocumentSnapshot doc){
    var memoList = SearchFB(insertDate: doc['insertdate'], labelColor: doc['labelcolor'], content: doc['content']);
    return Card(
      child: ListTile(
        title: Text(
          memoList.content
        ),
      ),
    );
  }


} // end

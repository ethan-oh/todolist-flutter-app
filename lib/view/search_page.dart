import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/functions/get_json.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late List memoData;
  late int conut;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    memoData = [];
    getData();
    conut = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // 검색 쿼리
                      print(memoData.length);
                    },
                    child: const Icon(Icons.search),
                  )
                ),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }


  // -- function --
    getData() async {
    memoData.addAll(await getJSONData('https://jsonplaceholder.typicode.com/posts'));   // Test 주소
    print(memoData.length);
    setState(() {
      
    });
  }



} // end

import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/model/memo/memo.dart';

class MemoProvider extends ChangeNotifier{
  // String _contents = '';
  // String _color = '';
  Memo _memoData = Memo(contentText: '', memoLabelColor: '', insertdate: '');
  String _content = '';
  String _id = '';

  // String get content => _contents;
  // String get color => _color;

  // addList(String mcontent, String mcolor){
  //   _contents = mcontent;
  //   _color = mcolor;
  //   notifyListeners();
  // }

  Memo get memoData => _memoData;
  String get content => _content;
  String get id => _id;

  addList(Memo memo){
    _memoData = memo;
    notifyListeners();
  }

  setDocId(String docId){
    _id = docId;
    notifyListeners();
  }

  updateContent(String contents){
    _content = contents;
    notifyListeners();
  }
}
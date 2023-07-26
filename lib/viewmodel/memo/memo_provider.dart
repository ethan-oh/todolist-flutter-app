import 'package:flutter/material.dart';
import 'package:team_four_todo_list_app/model/memo/memo.dart';

class MemoProvider extends ChangeNotifier{
  List _memoData = [];
  String _labelColor = '';

  List get memoData => _memoData;
  String get labelColor => _labelColor;

  addList(Memo data, String color){
    _memoData.add(data);
    _labelColor = color;
    notifyListeners();
  }
}
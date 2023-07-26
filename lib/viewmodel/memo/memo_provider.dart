import 'package:flutter/material.dart';

class MemoProvider extends ChangeNotifier{
  String _contents = '';
  String _color = '';

  String get content => _contents;
  String get color => _color;

  addList(String mcontent, String mcolor){
    _contents = mcontent;
    _color = mcolor;
    notifyListeners();
  }
}
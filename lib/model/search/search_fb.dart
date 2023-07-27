import 'package:cloud_firestore/cloud_firestore.dart';

class SearchFB{
  Timestamp insertDate;
  String labelColor;
  String content;

  SearchFB(
    {
      required this.insertDate,
      required this.labelColor,
      required this.content,
    }
  );

}
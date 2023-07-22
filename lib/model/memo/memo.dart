class Memo{
  int? seq;
  String titleText;
  String contentText;
  int? memoLabelColor;

  Memo(
    {
      this.seq,
      required this.titleText,
      required this.contentText,
      this.memoLabelColor,
    }
  );
}
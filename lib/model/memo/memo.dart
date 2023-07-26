class Memo{
  String contentText;
  String memoLabelColor;
  String? insertdate;

  Memo(
    {
      required this.contentText,
      required this.memoLabelColor,
      this.insertdate,
    }
  );
}
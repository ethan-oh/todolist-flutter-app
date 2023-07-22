import 'dart:convert';
import 'package:http/http.dart' as http;


/*
getJSONData 사용법
사용할 클래스에서 함수를 하나 선언 ex) getData()
getData() async {
  list.addAll(getJSONData('Uri 주소'));
  setState ..
}

만약 header에 result 나 results 가 있을 경우에는 아래와 같이 사용
getJSONData('Uri 주소', 'result')
*/

getJSONData(String uriPath, {String? responseHeader}) async {
  List data = [];
  var url = Uri.parse(uriPath);
  var response = await http.get(url);
  var convertData = json.decode(utf8.decode(response.bodyBytes));
  print('Return JSON Type = ${convertData.runtimeType}');

  if(convertData is Map<String, dynamic>){
    Map<String, dynamic> result = convertData[responseHeader];
    return result;
  } else {
    if(responseHeader == null){
      List result = convertData;
      data.addAll(result);
      return data;
    } else {
      List result = convertData[responseHeader];
      data.addAll(result);
      return data;
    }
  }
}
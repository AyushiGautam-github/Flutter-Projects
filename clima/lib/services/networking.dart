import 'package:http/http.dart' as http;
import 'dart:convert';

class networkhelper{
  networkhelper(this.url);
  final String url;

  Future getData() async{
    http.Response rs=await http.get(Uri.parse(url));
    if(rs.statusCode==200) {
      String data = rs.body;
      return jsonDecode(data);
    }
    else print(rs.statusCode);
  }
}
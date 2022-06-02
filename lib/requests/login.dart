import 'package:http/http.dart' as http;
import 'dart:convert';
import '../singletons/token.dart';

Future<bool> login(username, password) async {
  final response = await http.post(Uri.parse("http://192.168.0.121:3001/api/auth"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password
    })
  );
  if(response.statusCode == 401) {
    return false;
  } else {
    var data = json.decode(response.body);
    Token t1 = Token();
    t1.setTokenString(data['token']);
    t1.setName(data['name']);
    t1.setUsername(data['username']);
    t1.setUserId(data['id']);
    return true;
  }
}
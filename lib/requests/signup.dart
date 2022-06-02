import 'package:http/http.dart' as http;
import 'dart:convert';
import '../singletons/token.dart';

Future<bool> signup(name, username, password, email) async {
  final response = await http.post(Uri.parse("http://10.0.2.2:3001/api/users"),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'username': username,
      'password': password,
      'email': email
    })
  );
  if(response.statusCode == 200) {
    var data = json.decode(response.body);
    Token t1 = Token();
    t1.setTokenString(data['token']);
    t1.setName(data['name']);
    t1.setUsername(data['username']);
    return true;
  } else {
    return false;
  }
}
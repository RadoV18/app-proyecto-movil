import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> login(username, password) async {
  final response = await http.post(Uri.parse("http://10.0.2.2:3001/api/auth"),
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
    return true;
  }
}
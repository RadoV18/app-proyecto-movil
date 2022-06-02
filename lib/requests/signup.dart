import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> signup(name, username, password, email) async {
  final response = await http.post(Uri.parse("http://192.168.0.121:3001/api/users"),
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
    return true;
  } else {
    return false;
  }
}
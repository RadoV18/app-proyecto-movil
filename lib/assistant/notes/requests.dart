import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../singletons/token.dart';

Future<String> saveNote(String text) async {
  Token t1 = Token();
  final response = await http.post(
      Uri.parse("http://192.168.0.121:3001/api/notes/new/${t1.getUserId()}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'content': text
      }
    )
  );
  if(response.statusCode == 200) {
    return "Nota guardada.";
  }
  return "Ocurrió un error.";
}

Future<List<String>> getAllNotes() async {
  Token t1 = Token();
  final response = await http.get(
    Uri.parse("http://192.168.0.121:3001/api/notes/${t1.getUserId()}")
  );
  var data = json.decode(response.body);
  List<String> res = [];
  for(int i = 0; i < data.length; i++) {
    res.add(data[i]['content']);
  }
  return res;
}
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../singletons/token.dart';

Future<String> getJoke() async {
  final response = await http.get(
    Uri.parse("http://192.168.0.121:3001/api/jokes")
  );
  if(response.statusCode == 200) {
    var data = json.decode(response.body);
    return data['content'];
  } else {
    return "Ocurrió un error.";
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ip.dart';

Future<String> currentWeather(String city) async {
  final response = await http.post(Uri.parse("http://${getIp()}:3001/api/weather"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'city': city
    })
  );
  if(response.statusCode == 200) {
    var data = json.decode(response.body);
    return data['response'];
  }
  return "Ocurrió un error.";
}
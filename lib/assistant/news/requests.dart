import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ip.dart';

Future<List<String>> getNews(String query) async {
  final response = await http.get(
    Uri.parse('http://${getIp()}:3001/api/news/$query')
  );
  if(response.statusCode == 200) {
    var data = json.decode(response.body);
    List<String> res = [];
    res.add(data["articles"][0]["title"]);
    res.add(data["articles"][0]["description"]);
    res.add("Para más detalles, visita ${data["articles"][0]['url']}");
    return res;
  } else {
    return ["Ocurrió un error."];
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> recognize(base64) async {
  final response = await http.post(Uri.parse("http://10.0.2.2:3001/api/speech-recognition"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'config': {
          "encoding": "LINEAR16",
          "sampleRateHertz": 16000,
          "languageCode": "es-MX",
          "enableAutomaticPunctuation": "true"
        },
        'content': base64
      })
  );
  print(response.body);
  return response.body.toString();
}

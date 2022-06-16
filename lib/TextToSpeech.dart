import 'package:flutter_tts/flutter_tts.dart';

speak(msg) async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.setLanguage("es-US");
  await flutterTts.setPitch(1);
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(msg);
}

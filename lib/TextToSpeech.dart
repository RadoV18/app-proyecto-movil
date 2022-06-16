import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {

  FlutterTts flutterTts = FlutterTts();

  speak(msg) async {
    await flutterTts.setLanguage("es-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(msg);
  }
}


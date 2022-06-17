import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech{
  static final _speech = SpeechToText();
  static stop() {
    _speech.stop();
  }
  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error: $e'),
    );

    print("aqui");
    print(_speech.isAvailable);

    if (isAvailable) {
      _speech.listen(onResult: (value) => onResult(value.recognizedWords));
    }

    return isAvailable;
  }
}
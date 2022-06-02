import 'package:flutter/material.dart';
import 'dart:async';
import '../assistant/sendRequest.dart';
import '../Speech.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String text = 'Texto inicial';
  bool isListening = false;
  bool sendRequest = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aplicación'),
        backgroundColor: Color(0xff32746D),
      ),
      body: Center(
          child: Column(
            children: [
              Text(
                '${text}',
                style: TextStyle(fontSize: 70, color: Colors.black),
              ),
            ],
          )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff32746D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                toggleRecording();
                sendRequest = true;
              },
              style: ElevatedButton.styleFrom(
                primary: isListening  ? Colors.red : Color(0xff32746D),
              ),
              child: isListening  ? Icon(Icons.stop): Icon(Icons.mic),
            ),
          ],
        )
      ),
    );
  }
  Future toggleRecording() => Speech.toggleRecording(
    onResult: (text) async {
      setState(() => this.text = text);
      if(!isListening && sendRequest) {
        List<String> response = await assistantRequest(text);
        print(response);
      }
    },
    onListening: (isListening) {
      setState(() => this.isListening = isListening);
    },
  );

}
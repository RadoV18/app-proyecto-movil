import 'dart:convert';
import '../assistant/sendRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import '../TextToSpeech.dart';
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
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message, String userId) {
    final textMessage = types.TextMessage(
      author: types.User(id: userId),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aplicación'),
        backgroundColor: Color(0xff32746D),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: (message){},
        user: _user,
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
    onResult: (text) {
      setState(() async {
        if(!isListening && sendRequest) {
          _handleSendPressed(types.PartialText(text:text), '06c33e8b-e835-4736-80f4-63f44b66666c');
          List<String> response = await assistantRequest(text);
          for(int i = 0; i < response.length; i++) {
            _handleSendPressed(types.PartialText(text:response[i]), 'server');
            await speak(response[i]);
          }
          Speech.stop();
          print(response);
          if(response[0] == "Abriendo tabla...") {
            Navigator.pushNamed(context, '/table');
          }
        }
      }
      );
    },
    onListening: (isListening) {
      setState(() => this.isListening = isListening);
    },
  );
}
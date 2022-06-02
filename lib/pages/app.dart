import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

import 'dart:io';
import 'dart:async';

import '../Speech.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {


  int _selectedIndex = 0;
  int _tap = 1;
  String text = 'Texto inicial';
  bool isListening = false;

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

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
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
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
      /*
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

       */
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff32746D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(

              onPressed: ()=>{
                toggleRecording(),
                print("JAKAA"),
                print(this.text)

              },
                  /*

                  (){

                setState(() {
                  print('Presionado');
                  _tap++;
                  if(_tap % 2 == 0){
                    _selectedIndex = 1;



                  }
                  else{
                    _selectedIndex = 2;

                    toggleRecording();
                    print('Entro a la funcion');
                  }

                });
              },

              */
              style: ElevatedButton.styleFrom(
                primary: isListening  ? Colors.red : Color(0xff32746D),
              ),

              //icon: Icon(Icons.add),
              //color: _selectedIndex % 2 != 0 ? Colors.white : Colors.black,

              child: isListening  ? Icon(Icons.stop): Icon(Icons.mic),

            ),
          ],
        )

      ),

    );

  }
  Future toggleRecording() => Speech.toggleRecording(
    onResult: (text) => {setState(() => this.text = text)},

    onListening: (isListening) {
      setState(() => this.isListening = isListening);
      /*
      a
      if (!isListening) {
        Future.delayed(Duration(seconds: 1), () {
          Utils.scanText(text);
        });
      }

       */
    },
  );

}
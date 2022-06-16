import 'dart:convert';
import '../assistant/sendRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Speech.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class Tables extends StatefulWidget {
  const Tables({Key? key}) : super(key: key);


  @override
  State<Tables> createState() => _TableState();



}

class _TableState extends State<Tables>{
  String text = 'Texto inicial';
  bool isListening = false;
  bool sendRequest = false;
  bool flag = false;
  List<types.Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    throw Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tabla'),
        backgroundColor: Color(0xff32746D),
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //Numero de filas
                  children: _buildRows(15),
                ),
              ),
            )
          ],
        ),
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
          }
          print(response);
        }
      }
      );
    },
    onListening: (isListening) {
      setState(() => this.isListening = isListening);
    },
  );

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
          (index) => Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.grey,
        margin: EdgeInsets.all(4.0),
        //Texto de celdas
        child: Text("${index + 1}"),
      ),

    );
  }

  List <Widget> _buildHeaders(int count){
    flag = true;
    return List.generate(
      count,
          (index) => Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.amber,
        margin: EdgeInsets.all(4.0),
        //Texto de celdas
        child: Text("${index + 1}"),
      ),

    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
          (index) => Row(
        //Numero de columnas
        children: flag ? _buildCells(5) : _buildHeaders(5),
      ),
    );
  }

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

}


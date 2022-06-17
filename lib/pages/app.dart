import 'dart:convert';
import 'package:proyecto_final/assistant/tableRequest.dart';

import '../assistant/sendRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import '../TextToSpeech.dart';
import '../Speech.dart';
import '../singletons/TableModel.dart';

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

  bool tableFlag = false;

  List<String> colores = ['Amarillo', 'Azul', 'Rojo', 'Rosa', 'Morado', 'Verde',
    'Negro', 'Gris', 'Blanco', 'Lima', 'Violeta', 'Magenta', 'Fucsia', 'Menta',
    'Lavanda', 'Rosado', 'Cobre', 'Canela', 'Dorado', 'Turquesa', 'Amatista',
    'Purpura', 'Vino'];

  // Table
  double cellWidth = 100.0;
  double cellHeight = 40.0;
  double margin = 0.5;

  int counter = 1;

  TableModel tModel = TableModel();
  List<List<String>> table = [];

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
    if(tableFlag) {
      tModel = TableModel();
      table = tModel.getTable();
      return getTable();
    }
    return getChat();
  }

  Future toggleRecording() => Speech.toggleRecording(
    onResult: (text) {
        setState(() async {
          if(!isListening && sendRequest) {
            if(tableFlag) {
              if(text.toLowerCase().startsWith("cerrar tabla")) {
                await speak("cerrando tabla");
                setState(() {
                  tableFlag = false;
                });
              } else {
                List<String> response = tableRequest(text);
                for(int i = 0; i < response.length; i++) {
                  await speak(response[i]);
                }
                setState(() {
                  tModel = TableModel();
                  table = tModel.getTable();
                });
              }
            } else {
              _handleSendPressed(types.PartialText(text:text), '06c33e8b-e835-4736-80f4-63f44b66666c');
              List<String> response = await assistantRequest(text);
              for(int i = 0; i < response.length; i++) {
                _handleSendPressed(types.PartialText(text:response[i]), 'server');
                await speak(response[i]);
              }
              Speech.stop();
              print(response);
              if(response[0] == "Abriendo tabla...") {
                setState(() {
                  tableFlag = true;
                });
              }
            }
          }
        }
      );
    },
    onListening: (isListening) {
      setState(() => this.isListening = isListening);
    },
  );

  Widget getChat() => Scaffold(
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

  Widget getTable() => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Tabla'),
      backgroundColor: Color(0xff32746D),
    ),
    body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //Numero de filas
                    children: _buildTable(tModel.getRowCount(), tModel.getColumnCount()),
                  ),
                ),
              )
            ],
          ),
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

  // Table
  List<Widget> _buildTable(int rows, int columns) {
    List<Widget> result = [];
    for(int i = 0; i < rows; i++) {
      List<Widget> cells = [];
      for(int j = 0; j < columns; j++) {
        if(i == 0) {
          // header row
          if(j == 0) {
            // top left corner
            cells.add(cell("-", true));
          } else {
            cells.add(cell(colores[j], true));
          }
        } else if (j == 0) {
          // first column
          cells.add(cell(colores[i], true));
        } else {
          // cell
          cells.add(cell(table[i][j], false));
        }
      }
      result.add(
          Row( children: cells )
      );
    }
    return result;
  }

  Container cell(String value, bool isHeader) {
    return Container(
      alignment: Alignment.center,
      width: cellWidth,
      height: cellHeight,
      color: isHeader ? Colors.amber : Colors.white,
      margin: EdgeInsets.all(margin),
      //Texto de celdas
      child: Text(value),
    );
  }

}


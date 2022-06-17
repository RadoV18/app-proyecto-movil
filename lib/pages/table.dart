import 'package:flutter/material.dart';
import '../Speech.dart';
import '../singletons/TableModel.dart';


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

  double cellWidth = 100.0;
  double cellHeight = 40.0;
  double margin = 0.5;

  int counter = 1;

  late TableModel tModel;
  List<List<String>> table = [];

  @override
  Widget build(BuildContext context) {
    tModel = TableModel();
    table = tModel.getTable(); // init if empty
    return Scaffold(
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
  }

  @override
  void initState() {
    super.initState();
  }

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
            cells.add(cell(j.toString(), true));
          }
        } else if (j == 0) {
          // first column
          cells.add(cell(i.toString(), true));
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

  // Recording
  Future toggleRecording() => Speech.toggleRecording(
    onResult: (text) {
        setState(() async {
          print(isListening);
          if(!isListening && sendRequest) {
            print(text);
          }
        }
      );
    },
    onListening: (listen) {

      setState(() => isListening = listen);
    },
  );
}


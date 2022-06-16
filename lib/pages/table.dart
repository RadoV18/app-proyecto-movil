import 'package:flutter/material.dart';

class Tables extends StatefulWidget {
  const Tables({Key? key}) : super(key: key);


  @override
  State<Tables> createState() => _TableState();



}

class _TableState extends State<Tables>{
  bool flag = false;
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
    );
  }

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

}


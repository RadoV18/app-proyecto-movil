import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:record_mp3/record_mp3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
              onPressed: toggleRecording,
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
      if (!isListening) {
        Future.delayed(Duration(seconds: 1), () {
          Utils.scanText(text);
        });
      }

       */
    },
  );

}
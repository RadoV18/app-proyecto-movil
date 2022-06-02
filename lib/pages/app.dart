import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:record_mp3/record_mp3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';
import 'dart:async';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  int _tap = 1;
  String statusText = "";
  late String pathToAudio;
  bool isComplete = false;
  int i = 0;
  String aux = '';
  late String recordFilePath;

  //final recordingPlayer = AssetsAudioPlayer();


  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<void> startRecording() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      aux = recordFilePath;
/*



 */
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {

    });
  }

  Future<String?> stopRecording() async {
    bool s = RecordMp3.instance.stop();

    File file = File(aux);
    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(utf8.encode(fileBytes.toString()));
    final fileString = '${aux};base64,$base64String';
    print('Imprimiendo Base');
    print(fileString);

    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _playAudio = false;
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
                'Teto',
                style: TextStyle(fontSize: 70, color: Colors.red),
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
              onPressed: (){

                setState(() {
                  print('Presionado');
                  _tap++;
                  if(_tap % 2 == 0){
                    _selectedIndex = 1;
                    startRecording();
                  }
                  else{
                    _selectedIndex = 2;
                    stopRecording();

                  }

                });
              },

              style: ElevatedButton.styleFrom(
                primary: _selectedIndex == 1  ? Colors.red : Color(0xff32746D),
              ),

              //icon: Icon(Icons.add),
              //color: _selectedIndex % 2 != 0 ? Colors.white : Colors.black,

              child: _selectedIndex == 1 ? Icon(Icons.stop): Icon(Icons.mic),

            ),
          ],
        )
        /*
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.stop),
            label: 'Stop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Grabar',

          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffffffff),
        onTap: _onItemTapped,
        backgroundColor: Color(0xff32746D),
        */
      ),
    );
  }



  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "/sdcard/Download";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    print('Path');
    return sdPath + "/test_${i++}.mp3";
  }

}
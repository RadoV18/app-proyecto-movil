import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as path;
//import 'package:assets_audio_player/assets_audio_player.dart';

import 'dart:io';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  int _tap = 1;
  String _timerText = '';
  late String pathToAudio;
  late FlutterSoundRecorder _recordingSession;

  //final recordingPlayer = AssetsAudioPlayer();

  void initializer() async {

    pathToAudio = '/sdcard/Download/temp.wav';

    _recordingSession = FlutterSoundRecorder();
    await _recordingSession.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker
    );
    await _recordingSession.setSubscriptionDuration(Duration(milliseconds: 10));
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  void initState() {
    super.initState();
    initializer();
  }

  Future<void> startRecording() async {

    Directory directory = Directory(path.dirname(pathToAudio));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    _recordingSession.openAudioSession();
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );

    /*

     */
  }

  Future<String?> stopRecording() async {
    _recordingSession.closeAudioSession();
    File file = File(pathToAudio);
    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    final fileString = '${pathToAudio};base64,$base64String';
    print('Imprimiendo Base');
    print(fileString);

    return await _recordingSession.stopRecorder();

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
                _timerText,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        startRecording();
      } else if(_selectedIndex == 0){
        stopRecording();
      }
      print(_selectedIndex);
    });
  }

}
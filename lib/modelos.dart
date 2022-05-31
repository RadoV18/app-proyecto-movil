import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  int _item = -1;
  String _nombre = '';

  int get item => _item;

  set item(int value) {
    _item = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }
}
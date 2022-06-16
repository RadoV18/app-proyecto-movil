import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/pages/app.dart';
import 'package:proyecto_final/pages/login.dart';
import 'package:proyecto_final/pages/register.dart';
import 'package:proyecto_final/pages/table.dart';

import 'home.dart';
import 'modelos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name){
              case '/':
                return MaterialPageRoute(builder: (context) => Home());
              case '/app':
                return MaterialPageRoute(builder: (context) => App());
              case '/registro':
               return MaterialPageRoute(builder: (context) => Register());
              case '/login':
                return MaterialPageRoute(builder: (context) => Login());
              case '/table':
                return MaterialPageRoute(builder: (context) => Tables());
            }
          }
      ),
    );
  }
}

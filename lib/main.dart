import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/pages/app.dart';

import 'home.dart';
import 'modelos.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name){
              case '/':
              //break;
                return MaterialPageRoute(builder: (context) => Home());
              case '/app':
                return MaterialPageRoute(builder: (context) => App());
            // break;
              case '/dos':
              //return MaterialPageRoute(builder: (context) => Dos());

            //break;
              case '/tres':
                //return MaterialPageRoute(builder: (context) => Tres());

            //break;
            }

          }
      ),
    );
  }
}

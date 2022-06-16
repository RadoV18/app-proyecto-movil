import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

import 'modelos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var myProvider;
  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Inicio'),
            backgroundColor: Color(0xff32746D),
        ),
        body: Center (
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff32746D),
                      minimumSize: Size(150, 50),

                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Inicio de Sesión'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 50),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff32746D),
                      minimumSize: Size(150, 50),


                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registro');

                    },
                    child: const Text('Registrarse'),
                  ),
                ),

              ],
            )
        )

        /*
          appBar: AppBar(title: Text('Provider')) ,
          body: Center(

              child: Column (
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/uno');
                      },
                      child: Text('Pagina uno')
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/dos');

                      },
                      child: Text('Pagina dos')
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/tres');
                      },
                      child: Text('Pagina tres')
                  ),
                ],
              )
          )

         */
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            title: Text('Incio'),
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
                      Navigator.pushNamed(context, '/app');
                    },
                    child: const Text('Login'),
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
                      Navigator.pushNamed(context, '/app');

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

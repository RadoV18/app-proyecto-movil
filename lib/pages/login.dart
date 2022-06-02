import 'package:flutter/material.dart';
import 'package:proyecto_final/requests/login.dart';
import 'package:proyecto_final/utils/showToast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ingreso'),
        backgroundColor: Color(0xff32746D),
      ),
      body: Center(
          child: Form(
            key: _formKey,
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 70),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (text) {
                        username = text;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Usuario',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese un Usuario';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      onChanged: (text) {
                       password = text;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Contraseña',
                      ),
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese una contraseña';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                          bool isLogged = await login(username, password);
                          if(isLogged) {
                            Navigator.pushNamed(context, '/app');
                          } else {
                            showToast(context, "Usuario y/o contraseña incorrectos.");
                          }
                        }
                      },
                      child: const Text('Enviar'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff32746D)),
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
      ),
    );
  }
}

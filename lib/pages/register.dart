import 'package:flutter/material.dart';
import 'package:proyecto_final/requests/signup.dart';

import '../utils/showToast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String username = '';
  String email = '';
  String password = '';
  String passwordConfirm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registrarse'),
        backgroundColor: Color(0xff32746D),
      ),
        body: Center(
            child: Form(
              key: _formKey,
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 70),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        onChanged: (text) {
                          setState(() {
                            this.name = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nombre',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un nombre válido.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        onChanged: (text) {
                          setState(() {
                            this.username = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nombre de Usuario',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un usuario válido.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        onChanged: (text) {
                          setState(() {
                            this.email = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Correo Electrónico',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un correo electrónico válido.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        onChanged: (text) {
                          setState(() {
                            this.password = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Contraseña',
                        ),
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese una contraseña válida.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        onChanged: (text) {
                          setState(() {
                            this.passwordConfirm = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Confirmar contraseña',
                        ),
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese una contraseña válida.';
                          }
                          if (value != password) {
                            return 'Las contraseñas deben coincidir.';
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
                            bool ok = await signup(this.name, this.username, this.password, this.email);
                            if(ok) {
                              print("ok");
                              setState(() {
                                name = '';
                                username = '';
                                password = '';
                                email = '';
                                passwordConfirm = '';
                              });
                            }
                            showToast(context, ok ? "Registro realizado correctamente." :
                            "El usuario ya se encuentra registrado");
                          }
                        },
                        child: const Text('Enviar'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff32746D)),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            )
        ),
    );
  }

}

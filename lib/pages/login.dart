import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su Usuario',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese un Usuario';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su Contraseña',
                    ),
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese una contraseña';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        Navigator.pushNamed(context, '/app');

                      }
                    },
                    child: const Text('Enviar'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff32746D)),

                    ),
                  ),
                ],
              ),
            ),

          )

      ),
    );
  }
}

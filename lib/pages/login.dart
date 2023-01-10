import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login/Provider/user_provider.dart';

import 'package:login/model/model.dart';

import 'package:login/pages/pages.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<RecursosProvider>(context, listen: true);
    final List<User> users = userprovider.recursoList;

    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    String usuarioCorrecto;
    String passwordCorrecto;

    String username = "";
    String password = "";

    void registrase() {}

    void iniciarSesion() {
      FormState _formState = _formkey.currentState!; //
      if (_formState.validate()) {
        _formState.save();
        for (int i = 0; i < users.length; i++) {
          usuarioCorrecto = users[i].dni.toString();
          passwordCorrecto = users[i].password;
          // roleCorrecto = users[i].role;
          if (usuarioCorrecto.toLowerCase() == username.toLowerCase() &&
              passwordCorrecto == password) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  i: i,
                  users: users[i],
                ),
              ),
            );
          } else {
            print('Este usuario és inválido');
          }
        }
      }
    }

    @override
    void initState() {
      super.initState();
      registrase();
    }

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: ListView(children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Image.network(
                        'https://i.pinimg.com/564x/8c/bb/2b/8cbb2b0cf456b78ee7e5fa38df3d4c7c.jpg'),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'DNI',
                        hintText: 'Introduzca su DNI',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El campo no debe estar avcio';
                        } else {
                          if (value.contains(' ')) {
                            return 'El campo contine espacio';
                          } else {
                            return null;
                          }
                        }
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'contraseña',
                        hintText: 'Introduzca contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El campo no debe estar vacio';
                        } else {
                          if (value.length < 6) {
                            return 'La contraseña es debil';
                          } else {
                            return null;
                          }
                        }
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(children: [
                     
                      Expanded(
                        child: MaterialButton(
                          height: 60,
                          color: Colors.lightBlue[200],
                          onPressed: () {
                            iniciarSesion();
                            setState(() {});
                          },
                          child: const Text('Login'),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ])));
  }
}

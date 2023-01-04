import 'package:flutter/material.dart';
import 'package:login/Provider/user_provider.dart';
import 'package:login/model/user_model.dart';
import 'package:login/pages/cliente.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/usuario.dart';
import 'package:provider/provider.dart';

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
    // String roleCorrecto;

    String username = "";
    String password = "";
    // String role = "";

    void registrase() {}

    void iniciarSesion() {
      FormState _formState = _formkey.currentState!; //
      if (_formState.validate()) {
        _formState.save();
        for (int i = 0; i < users.length; i++) {
          usuarioCorrecto = users[i].nombreCompleto;
          passwordCorrecto = users[i].password;
          // roleCorrecto = users[i].role;
          if (usuarioCorrecto.toLowerCase() == username.toLowerCase() &&
                  passwordCorrecto ==
                      password /* &&
              roleCorrecto == role*/
              ) {
            print('Estte es mi username : ${username}');
            print('Estte es mi password : ${password}');
            print('Estte es mi role : ${users[i].role}');
            print('Estte es mi direccion : ${users[i].direccion}');
            print('Estte es mi estatus : ${users[i].estatus}');
            switch (users[i].role) {
              case 'admin':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      username: username,
                      role: users[i].role,
                      direccion: users[i].direccion,
                      status: users[i].estatus,
                    ),
                  ),
                );
                break;
              case 'cliente':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        cliente(
                         username: username,
                      role: users[i].role,
                      direccion: users[i].direccion,
                      status: users[i].estatus,
                          ),
                  ),
                );
                break;
              case 'usuario':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => usuario(
                      username: username,
                      role: users[i].role,
                      direccion: users[i].direccion,
                      status: users[i].estatus,
                    ),
                  ),
                );
                break;
            }
          } else {
            print('Este usuario é inválido');
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
                     SizedBox(height: MediaQuery.of(context).size.height * .3,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'usuario',
                        hintText: 'Introduzca usuario',
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
                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              registrase();
                              setState(() {});
                              // Navigator.push(
                              //   context,
                              //   // MaterialPageRoute(
                              //   //   builder: (context) => cliente(
                              //   //     username: 'Alberto',
                              //   //     role: '',
                              //   //   ),
                              //   // ),
                              // );
                            },
                            child: const Text("Registrarse"),
                          ),
                          MaterialButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              iniciarSesion();
                              setState(() {});
                            },
                            child: const Text('Login'),
                          )
                        ])
                  ],
                ),
              ),
            ])));
  }
}

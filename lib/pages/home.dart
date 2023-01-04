import 'package:flutter/material.dart';
import 'package:login/model/user_model.dart';

class HomePage extends StatelessWidget {
  HomePage(
      {required this.username,
      required this.role,
      required this.direccion,
      required this.status});
  String username;
  String role;
  String direccion;
  bool status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    'Panel de administrador'.toUpperCase(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Center(
                    child: Text('Bienvenido ${username},${direccion},${role}'),
                  ),
                  CircleAvatar(
                    radius: 40,
                    child: Text(username.toLowerCase()),
                    backgroundColor: status == true ? Colors.red : Colors.amber,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:login/Provider/user_provider.dart';
// import 'package:login/model/user_model.dart';
// import 'package:login/pages/home.dart';
// import 'package:provider/provider.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {

    
//   final userprovider = Provider.of<RecursosProvider>(context,listen: true);
//   final List<User> users = userprovider.recursoList;
  


//     final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//     String usuarioCorrecto = "${users[0].nombreCompleto}";
//     String passwordCorrecto = "${users[0].password}";

//     String email = "";
//     String password = "";

//     void registrase() {}

//     void iniciarSesion() {
//       FormState _formState = _formkey.currentState!; //
//       if (_formState.validate()) {
//         _formState.save();

//         if (usuarioCorrecto.toLowerCase() == email.toLowerCase() &&
//             passwordCorrecto == password) {
//           print('Estte es mi email : ${email}');
//           print('Estte es mi password : ${password}');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomePage(),
//             ),
//           );
//         } else {
//           print('Este email é inválido');
//         }
//       }
//     }


//     return Scaffold(
//       body: Container(
//           padding: EdgeInsets.all(16),
//           child: ListView(
//             children: [
//               Card(
//                 margin: EdgeInsets.all(16),
//                 elevation: 4.0,
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: Text('iniciar sesion'),
//                           subtitle: Text('Ejemplo de login'),
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'usuario',
//                             hintText: 'Introduzca usuario',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'El campo no debe estar avcio';
//                             } else {
//                               if (value.contains(' ')) {
//                                 return 'El campo contine espacio';
//                               } else {
//                                 return null;
//                               }
//                             }
//                           },
//                           onSaved: (value) {
//                             email = value!;
//                           },
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'contraseña',
//                             hintText: 'Introduzca contraseña',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'El campo no debe estar vacio';
//                             } else {
//                               if (value.length < 6) {
//                                 return 'La contraseña es debil';
//                               } else {
//                                 return null;
//                               }
//                             }
//                           },
//                           onSaved: (value) {
//                             password = value!;
//                           },
//                         ),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               MaterialButton(
//                                 child: Text("Registrarse"),
//                                 color: Colors.redAccent,
//                                 onPressed: () {
//                                   registrase();
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HomePage(),
//                                     ),
//                                   );
//                                 },
//                               ),
//                               MaterialButton(
//                                 child: Text("Login"),
//                                 color: Colors.blueAccent,
//                                 onPressed: () {
//                                   iniciarSesion();
//                                   setState(() {});
//                                 },
//                               )
//                             ])
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:login/Provider/user_provider.dart';
// import 'package:login/model/user_model.dart';
// import 'package:login/pages/home.dart';
// import 'package:provider/provider.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     final userprovider = Provider.of<RecursosProvider>(context, listen: true);
//     final List<User> users = userprovider.recursoList;

//     final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//     String usuarioCorrecto;
//     String passwordCorrecto;

//     String email = "";
//     String password = "";

//     void registrase() {}

//     void iniciarSesion() {
//       FormState _formState = _formkey.currentState!; //
//       if (_formState.validate()) {
//         _formState.save();
//         for (int i = 0; i < users.length; i++) {
//           usuarioCorrecto = users[i].nombreCompleto;
//           passwordCorrecto = users[i].password;
//           if (usuarioCorrecto.toLowerCase() == email.toLowerCase() &&
//               passwordCorrecto == password) {
//             print('Estte es mi email : ${email}');
//             print('Estte es mi password : ${password}');
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>  HomePage(nombre:  email),
//               ),
//             );
//           } else {
//             print('Este email é inválido');
//           }
//         }
//       }
//     }

//     @override
//     void initState() {
//       super.initState();
//       registrase();
//     }

//     return Scaffold(
//         body: Container(
//             padding: const EdgeInsets.all(16),
//             child: ListView(children: [
//               Form(
//                 key: _formkey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'usuario',
//                         hintText: 'Introduzca usuario',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'El campo no debe estar avcio';
//                         } else {
//                           if (value.contains(' ')) {
//                             return 'El campo contine espacio';
//                           } else {
//                             return null;
//                           }
//                         }
//                       },
//                       onSaved: (value) {
//                         email = value!;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'contraseña',
//                         hintText: 'Introduzca contraseña',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'El campo no debe estar vacio';
//                         } else {
//                           if (value.length < 6) {
//                             return 'La contraseña es debil';
//                           } else {
//                             return null;
//                           }
//                         }
//                       },
//                       onSaved: (value) {
//                         password = value!;
//                       },
//                     ),
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           MaterialButton(
//                             color: Colors.redAccent,
//                             onPressed: () {
//                               registrase();
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>  HomePage(nombre: 'Alberto',),
//                                 ),
//                               );
//                             },
//                             child: const Text("Registrarse"),
//                           ),
//                           MaterialButton(
//                             color: Colors.blueAccent,
//                             onPressed: () {
//                               iniciarSesion();
//                               setState(() {});
//                             },
//                           child: const Text('Login'),
//                           )
//                         ])
//                   ],
//                 ),
//               ),
//             ])));
//   }
// }

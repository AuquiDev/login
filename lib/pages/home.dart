import 'package:flutter/material.dart';

import 'package:login/model/model.dart';

import 'package:login/utils/utils.dart';

import 'package:login/pages/pages.dart';

import 'package:login/widget/widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key, required this.users, required this.i});
  int i;
  User users;

  @override
  Widget build(BuildContext context) {
    // Imagenes segun genero de usuario
    String images = '';
    switch (users.genero) {
      case 'femenino':
        images = 'https://cdn-icons-png.flaticon.com/512/634/634761.png';
        break;
      case 'masculino':
        images = 'https://cdn-icons-png.flaticon.com/512/7467/7467676.png';
        break;
      default:
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
            padding: const EdgeInsets.all(10),
            child: Image.network(images, color: Colors.indigo)),
        title: Text(
          'Usuario ${users.role}'.toUpperCase(),
          style: const TextStyle(
              color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: users.estatus == true
                ? Column(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text(
                        'cuenta activa',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  )
                : Column(
                    children: const [
                      Icon(Icons.offline_bolt, color: Colors.redAccent),
                      Text(
                        'cuenta inactiva',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FotoPerfil(
              image: users.image,
              status: users.estatus,
              i: i,
            ),
            
            TextLogin(
              color: Colors.black,
              fontSize: 18,
              title: users.cargo.toUpperCase(),
              fontWeight: FontWeight.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[200],
                  child: TextLogin(
                    fontSize: 20,
                    title: users.nombreCompleto.toUpperCase().substring(0, 1),
                  ),
                ),
                TextLogin(
                    color: Colors.blue.withOpacity(.8),
                    fontSize: 17,
                    title: '${users.nombreCompleto} ${users.apellido} '
                        .substring(
                      1,
                    )),
                users.estatus == true
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UsuarioeditPage(
                                        i: i,
                                      )));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black87,
                        ))
                    : Text('')
              ],
            ),

            //TODO: roles de usuarios y acceso a los modulos
            users.estatus == true
                ? PanelDashborad(
                    users: users,
                  )
                : Column(
                    children: const [
                      Icon(
                        Icons.warning_rounded,
                        size: 100,
                        color: Colors.black45,
                      ),
                      Text(
                        'Lo sentimos, su cuenta ha sido deshabilitada temporalmente.\nComuníquese con el administrador del sistema para solucionar este problema.',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

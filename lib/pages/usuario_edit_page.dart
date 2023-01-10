// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:login/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:login/model/model.dart';
import 'package:login/utils/utils.dart';
import 'package:login/widget/widget.dart';

import 'package:login/productos/product_screen.dart';

class UsuarioeditPage extends StatelessWidget {
  UsuarioeditPage({super.key, required this.i});
  int i;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<RecursosProvider>(context, listen: true);
    final List<User> users = userProvider.recursoList;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: width < 500 ? 90 : 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.indigo),
        elevation: 0,
        title: // Usuarios : lista de usuarios del sistema
            _ListaDeUsuarios(users: users, i: i),
      ),
      body: Stack(
        children: [
          // DATOS DE USUARIO
          SingleChildScrollView(
            child: Stack(
              children: [
                ...List.generate(
                    1,
                    (index) => EditingWidgetUser(
                          height: height,
                          users: users[i],
                          i: i,
                        )),
              ],
            ),
          ),
          // BOTON DE EDITAR PERFIL
          width < 500
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                      onTap: () {
                        userProvider.selectedUser =
                            userProvider.recursoList[i].copy();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductScreen()));
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.teal[400],
                          ),
                          child: Center(
                              child: TextLogin(
                            fontSize: 17,
                            title: 'Editar perfil',
                            color: Colors.white,
                          )))),
                )
              : Positioned(
                  right: width * .45,
                  bottom: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal[400],
                    radius: 30,
                    child: IconButton(
                        onPressed: () {
                          userProvider.selectedUser =
                              userProvider.recursoList[i].copy();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductScreen()));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.yellowAccent,
                        )),
                  ),
                )
        ],
      ),
    );
  }
}

//Lista de usuarios AppBar
class _ListaDeUsuarios extends StatelessWidget {
  const _ListaDeUsuarios({
    Key? key,
    required this.users,
    required this.i,
  }) : super(key: key);

  final List<User> users;
  final int i;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...users.map((e) => e.nombreCompleto != users[i].nombreCompleto
              ? Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: e.estatus == true
                                ? Colors.tealAccent
                                : Colors.red[200],
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(e.image),
                        ),
                      ),
                      TextLogin(
                        fontSize: 13,
                        title: e.nombreCompleto,
                        color: e.estatus == true ? Colors.teal : Colors.red,
                      ),
                      TextLogin(
                        fontSize: 10,
                        title: e.estatus == true ? 'activo' : 'inactivo',
                        color: e.estatus == true ? Colors.teal : Colors.red,
                      )
                    ],
                  ),
                )
              : const Text('')),
        ],
      ),
    );
  }
}

class EditingWidgetUser extends StatelessWidget {
  const EditingWidgetUser(
      {Key? key, required this.height, required this.users, required this.i})
      : super(key: key);

  final double height;
  final User users;
  final int i;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
    return Column(
      children: [
        // FOTO DE PERFIl
        FotoPerfil(
          image: users.image,
          status: users.estatus,
          i: i,
        ),
        // Datos de Usuarios
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(bottom: 20, left: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.teal.withOpacity(.5), Colors.white])),
          child: Column(
            children: [
              TextLogin(
                fontSize: 18,
                title: '${users.nombreCompleto} ${users.apellido}',
                color: Colors.teal,
              ),
              TextLogin(
                fontSize: 16,
                title: 'Cargo: ${users.cargo}'.toUpperCase(),
                color: Colors.black.withOpacity(.7),
              ),
              spacing20,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    width < 500
                        ? SizedBox(
                            width: width * .1,
                          )
                        : const Text(''),
                    Container(
                      width: width < 500 ? width * .7 : width * .4,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black.withOpacity(.15),
                      ),
                      child: Column(children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(users.image),
                          ),
                          title: const Text('Nombre Usuario:'),
                          subtitle:
                              Text('${users.nombreCompleto} ${users.apellido}'),
                          trailing: Column(
                            children: [
                              const Icon(Icons.star_border),
                              TextLogin(
                                fontSize: 10,
                                title: users.calification.toString(),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: const Text('Direccion:'),
                          subtitle: Text(users.direccion),
                        ),
                        ListTile(
                          title: const Text('Documento de Identidad:'),
                          subtitle: Text(users.dni.toString()),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.phone,
                            size: 20,
                          ),
                          minLeadingWidth: 0,
                          title: const Text('Telefono:'),
                          subtitle: Text(users.telefono.toString()),
                        ),
                      ]),
                    ),
                    width < 500 ? wspacing30 : wspacing100,
                    Container(
                      width: width < 500 ? width * .7 : width * .4,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black.withOpacity(.15),
                      ),
                      child: Column(children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              images,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          title: const Text('genero:'),
                          subtitle: Text(users.genero.toUpperCase()),
                        ),
                        ListTile(
                          title: const Text('Contraseña:'),
                          subtitle: Text(
                            users.password,
                            selectionColor: Colors.red,
                          ),
                        ),
                        ListTile(
                          title: const Text('Tipo de Usuario:'),
                          subtitle: Text(users.role),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.email,
                            size: 20,
                          ),
                          minLeadingWidth: 0,
                          title: const Text('Correo electronico:'),
                          subtitle: Text(users.correo.toString()),
                        ),
                      ]),
                    ),
                    width < 500
                        ? SizedBox(
                            width: width * .2,
                          )
                        : const Text(''),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

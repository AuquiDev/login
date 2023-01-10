import 'package:flutter/material.dart';

import 'package:login/model/model.dart';
import 'package:login/productos/produtos.dart';
import 'package:login/utils/utils.dart';

// ignore: must_be_immutable
class PanelDashborad extends StatelessWidget {
  PanelDashborad({
    super.key,
    required this.users,
  });

  User users;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.email_outlined),
          subtitle: TextLogin(
              color: Colors.black45,
              fontSize: 15,
              title: '${users.cargo} Andean Lodges'),
          title: TextLogin(
            color: Colors.black45,
            fontSize: 15,
            title: users.correo,
            fontWeight: FontWeight.normal,
          ),
        ),
        ListTile(
            leading: const Icon(Icons.phone),
            title: TextLogin(
              color: Colors.black45,
              fontSize: 15,
              title: users.telefono.toString(),
              fontWeight: FontWeight.normal,
            )),
        TextLogin(fontSize: 20, title: 'Modulos'),
        Container(
          height: height >= 500 ? height * .4 : height * .8,
          padding: height >= 500
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 25)
              : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(
            top: 20,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: height >= 500
                      ? const NetworkImage(
                          'https://i.pinimg.com/564x/1f/20/0f/1f200f2f172e42fff38207d656819680.jpg')
                      : const NetworkImage(
                          'https://i.pinimg.com/564x/24/6e/28/246e28d377705a2cf7ee3f305e1e238b.jpg')),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 8),
                  blurRadius: 30,
                  color: Colors.black.withOpacity(.4),
                )
              ]),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              //TODO: si el usuario es Admin entoces tendra acceso a este modulo
              users.role == 'admin'
                  ? ModulosPanel(
                      color: Colors.red,
                      icon: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Productos(users: users,)));
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      title: 'Usuarios',
                    )
                  : const Text(''),

              //TODO: los Usuarios de Oficina tendran accesos al panel de reportes

              ModulosPanel(
                  color: Colors.blueGrey,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  title: 'Reportes'),

              //TODO: los Usuarios de loogistica tendran accesos al panel de almacen

              ModulosPanel(
                  color: Colors.teal,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.storage,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  title: 'Almacen'),

              //TODO: los Usuarios de loogistica tendran accesos al panel de Entradas/salidas

              ModulosPanel(
                  color: Colors.indigoAccent,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  title: 'E/S'),

              //TODO: los Usuarios de loogistica tendran accesos al panel de Entradas/salidas

              ModulosPanel(
                  color: Colors.indigoAccent,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cookie,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  title: 'Cocina'),

              //TODO: los Usuarios de loogistica tendran accesos al panel de Entradas/salidas

              ModulosPanel(
                  color: const Color.fromARGB(255, 205, 90, 2),
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.zoom_in_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  title: 'otros'),

              //TODO: menus, programacion de grupos
              ModulosPanel(
                  color: const Color.fromARGB(255, 205, 90, 2),
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.local_post_office_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  title: 'menus'),
            ],
          ),
        ),
      ],
    );
  }
}

class ModulosPanel extends StatelessWidget {
  ModulosPanel({
    required this.color,
    required this.icon,
    required this.title,
  });
  String title;
  IconButton icon;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color.withOpacity(.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 10,
                color: Colors.black.withOpacity(.1),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ],
        ));
  }
}

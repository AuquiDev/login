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
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Panel de administrador'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Divider(
                    color: Colors.red,
                    thickness: 2,
                    endIndent: MediaQuery.of(context).size.width * .25,
                  ),
                  
                  ListTile(
                    title: Text(
                    'Bienvenido $username',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black54),
                  ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rol: ${role}'),
                        Text('direccion: ${direccion}'),
                        
                      ],
                    ),
                    leading: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12
                      ),
                      child: IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.person),
                        color:Colors.purple,
                        ),
                    ),
                    
                  )
                ],
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: status == true ? Colors.red : Colors.amber,
                child: Text(
                  username.substring(0, 1).toUpperCase(),
                  style: const TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class usuario extends StatelessWidget {
  usuario({
    required this.username,
    required this.role,
     required this.direccion,
     required this.status
    });
   String username;
   String role;
   String direccion;
   bool status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Panel de USUARIO'),
             SizedBox(height: 30,),
            Text('bienvenido ${username}'),
            CircleAvatar(
            radius: 40,
            child: Text(role.toLowerCase()),
            backgroundColor: status == true ? Colors.red : Colors.amber,
          )
          ],
        ),
      ),
    );
  }
}
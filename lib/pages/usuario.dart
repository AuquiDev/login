import 'package:flutter/material.dart';

class usuario extends StatelessWidget {
  usuario(
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Panel de USUARIO'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'bienvenido ${username}'.toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30,),
                   Text(
                    'Rol: ${role}'.toUpperCase(),
                    style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,color: Colors.purple),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child:Container (
                
                margin: EdgeInsets.all(50),
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  color: status == true ? Colors.red : Colors.amber,
                ),
                child: Text(username.toUpperCase().substring(0,1),style: TextStyle(fontSize: 60),),
               
              ),
            )
          ],
        ),
      ),
    );
  }
}

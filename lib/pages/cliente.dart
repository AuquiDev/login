import 'package:flutter/material.dart';

class cliente extends StatelessWidget {
  cliente(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Panel de CLIENTE'.toUpperCase(),
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      'https://www.grandespymes.com.ar/wp-content/uploads/2019/12/GoldenRule_HR-blog_golden_rule_HR-blog_golden_rule-1.png')),
              ListTile(
                title:  Text('bienvenido ${username}'),
                subtitle:  Text('Rol: ${role}'),
                leading: Icon(Icons.home_filled),
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: status == true ? Colors.red : Colors.green,
                child: Text(
                  role.toUpperCase().substring(0, 1),
                  style: TextStyle(fontSize: 90),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

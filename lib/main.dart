import 'package:flutter/material.dart';
import 'package:login/Provider/user_provider.dart';
import 'package:login/productos/produtos.dart';
import 'package:provider/provider.dart';


import 'package:login/pages/login.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,
            create: (_) {
              return RecursosProvider();
            }),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Login(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login/Provider/user_provider.dart';

import 'package:login/model/model.dart';

import 'package:login/productos/product_screen.dart';


class FotoPerfil extends StatelessWidget {
  const FotoPerfil(
      {Key? key, required this.image, required this.status, required this.i})
      : super(key: key);

  final String image;
  final bool status;
  final int i;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<RecursosProvider>(context, listen: true);
    final List<User> users = userProvider.recursoList;

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(31, 73, 56, 56),
      ),
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 100,
              backgroundImage: NetworkImage(
                image,
              ),
            ),
            status == true
                ? Positioned(
                    right: 0,
                    bottom: 8,
                    child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          
                          // crear el modulo de edicion de perfil CAMARA
                          userProvider.selectedUser =
                              userProvider.recursoList[i].copy();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductScreen()));
                        },
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          size: 40,
                        )),
                  )
                : const Text('')
          ],
        ),
      ),
    );
  }
}

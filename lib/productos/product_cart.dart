import 'package:flutter/material.dart';

import 'package:login/model/model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _decoration(),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 400,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackGorundImage(
              image: user.image,
            ),
            _ProductDetails(
              name: user.nombreCompleto,
              rol: user.role,
            ),
            Positioned(
                top: 0,
                right: 0,
                child: _priceTag(
                  calification: user.calification,
                )),
            if (!user.estatus)
              Positioned(top: 0, left: 0, child: _NotAvailable())
          ],
        ));
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0, 5),
            blurRadius: 10,
          )
        ]);
  }
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Activo'.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}

class _priceTag extends StatelessWidget {
  _priceTag({required this.calification});
  int calification;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      ),
      width: 100,
      height: 70,
      child: FittedBox(
        child: Text(
          'Calificacion: ${calification}',
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  _ProductDetails({required this.name, required this.rol});
  final String name;
  final String rol;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomLeft: Radius.circular(30))),
      height: 80,
      width: MediaQuery.of(context).size.width * .7,
      child: Column(children: [
        ListTile(
          title: Text(
            name.toUpperCase(),
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            rol.toUpperCase(),
            style: const TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}

class _BackGorundImage extends StatelessWidget {
  _BackGorundImage({required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
          width: double.infinity,
          height: 400,
          child:
              // image.toLowerCase() == null
              // ?  Image.asset('assets/no_image.png'):
              FadeInImage(
            fit: BoxFit.fill,
            placeholder: const AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(image),
          )),
    );
  }
}

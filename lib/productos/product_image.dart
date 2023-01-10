import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductImage extends StatelessWidget {
   ProductImage({super.key, this.image});
  String? image;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      width: width<500 ?  double.infinity : width*.5,
      height: 450,
      child:  Opacity(
        opacity: .8,
        child: ClipRRect(
          borderRadius: const BorderRadius.only( 
            topLeft: Radius.circular(45), 
            topRight: Radius.circular(45)),
          child:  getImage(image),
          
        ),
      ),
    );
  }

  Widget getImage(String? picture) {
     if(picture == null ) {
       return  Image.asset('assets/no-image.png',fit: BoxFit.cover,);
     }         
         
     if (picture.startsWith('http')) {
       return FadeInImage(
            image: NetworkImage(image!),
            placeholder: const AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
          );
     }

      return Image.file(
          File(picture),
          fit: BoxFit.cover,
        );
  }

  BoxDecoration _decoration() => const BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45), 
          topRight: Radius.circular(45)),
     boxShadow: [
      BoxShadow(
        offset: Offset(0, 7),
        blurRadius: 10,
        color: Colors.black26
      )
     ]
     );
}

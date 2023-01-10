import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextLogin extends StatelessWidget {
    TextLogin({super.key,  this.color, required this.fontSize, required this.title, this.fontWeight});

  String title;
  Color? color;
  double fontSize;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight, color: color,),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubTitleTextWidget extends StatelessWidget {
  SubTitleTextWidget(
      {super.key,
      required this.label,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal,
      this.textDecoration = TextDecoration.none,
      this.color}); //Varsyılan alabilir ya da eklenebilinir

  String label;
  double fontSize;
  FontWeight? fontWeight;
  TextDecoration textDecoration;
  Color? color;
  FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        color: color,
        fontStyle: fontStyle,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key? key,
    this.size = 15.0,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
    this.decoration = TextDecoration.none,
    this.align = TextAlign.start,
  }) : super(key: key);

  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextDecoration decoration;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        decoration: decoration,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.isAlign = false,
    this.isUnderline = false,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isAlign;
  final bool? isUnderline;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isAlign! ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "Prompt",
        fontWeight: this.fontWeight,
        decoration:
            isUnderline! ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

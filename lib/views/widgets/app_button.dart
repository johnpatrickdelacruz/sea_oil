import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.label,
    required this.onPress,
    this.textSize,
    required this.height,
    required this.type,
    required this.disabled,
  }) : super(key: key);

  final String? label;
  final VoidCallback onPress;
  final double? textSize;
  final double height;
  final ButtonType type;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Text textLabel = Text(
      label!,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.w700,
          fontFamily: "Prompt"),
    );

    Widget labelWidget = textLabel;

    Widget widget;
    switch (type) {
      case ButtonType.withBackground:
        widget = ElevatedButton(
          child: labelWidget,
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8),
            ),
          ),
          onPressed: onPress,
        );

        break;

      case ButtonType.text:
        widget = ElevatedButton(
          child: labelWidget,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
          onPressed: onPress,
        );
        break;

      case ButtonType.withBorder:
        widget = ElevatedButton(
          child: labelWidget,
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8),
            ),
          ),
          onPressed: onPress,
        );
        break;

      case ButtonType.withBackground:
      default:
        widget = Container();

        break;
    }

    return ButtonTheme(
      minWidth: size.width,
      height: height,
      child: widget,
    );
  }

  doNothing() {}
}

enum ButtonType { withBackground, text, withBorder }

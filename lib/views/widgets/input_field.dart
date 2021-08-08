import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.labelText,
    required this.icon,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final String labelText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: icon,
          suffixStyle: const TextStyle(color: Colors.deepPurple)),
    );
  }
}

import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double screenHeight = mediaQueryData.size.height;
    final double screenWidth = mediaQueryData.size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child:
            Container(height: screenHeight, width: screenWidth, child: child),
      ),
    );
  }
}

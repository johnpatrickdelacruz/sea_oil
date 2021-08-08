import 'package:flutter/material.dart';
import 'package:sea_oil/views/widgets/landing/landing_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LandingScreen(),
    );
  }
}

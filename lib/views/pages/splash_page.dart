import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      BlocProvider.of<NavigationBloc>(context).add(NavigationToLogin());
    }).catchError((error) => throw Exception(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  child: Center(
                    child: Image.asset(
                      ('assets/price_locq_logo.png'),
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

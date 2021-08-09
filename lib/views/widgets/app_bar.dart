import 'package:flutter/material.dart';
import 'package:sea_oil/views/widgets/app_text.dart';

class AppbarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  AppbarWithTitle({Key? key, required this.title, required this.actions})
      : super(key: key);

  final String title;
  final Widget actions;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          titleSpacing: 0.0,
          elevation: 5.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Container(
            height: 25,
            child: AppText(
              text: title,
              color: Colors.purple,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: <Widget>[
            actions,
          ],
        ),
      ),
    );
  }
}

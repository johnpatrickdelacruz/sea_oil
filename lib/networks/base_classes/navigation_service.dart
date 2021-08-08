import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, bool predicate,
      {dynamic arguments}) async {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => predicate,
        arguments: arguments);
  }

  void goBack() => navigatorKey.currentState!.pop();
}

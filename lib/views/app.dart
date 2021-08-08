import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_bloc.dart';
import 'package:sea_oil/networks/base_classes/navigation_service.dart';
import 'package:sea_oil/views/router.dart';

import '../locator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (_) => NavigationBloc(),
      child: MaterialApp(
        navigatorKey: serviceLocator<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        onGenerateRoute: RouterManager.generateRoute,
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/bloc_observer.dart';
import 'package:sea_oil/locator.dart';
import 'package:sea_oil/views/app.dart';

import 'blocs/login/login.export.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  Bloc.observer = SimpleBlocObserver();

  final List<BlocProvider> providers = [
    BlocProvider<LoginBloc>(create: (_) => serviceLocator<LoginBloc>()),
  ];

  runZonedGuarded<Future>(
    () async =>
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then(
      (_) => runApp(
        MultiBlocProvider(
          providers: providers,
          child: App(),
        ),
      ),
    ),
    (error, stackTrace) => print(error),
  );

  //  (error, stackTrace) async => await helper.reportError(error, stackTrace), report to sentry error
}

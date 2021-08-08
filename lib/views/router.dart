import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_event.dart';
import 'package:sea_oil/locator.dart';
import 'package:sea_oil/networks/model/stations.dart';
import 'package:sea_oil/views/pages/landing_page.dart';
import 'package:sea_oil/views/pages/login_page.dart';
import 'package:sea_oil/views/pages/search_page.dart';
import 'package:sea_oil/views/pages/splash_page.dart';

class RouterManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      case Routes.login:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _transitionBuilder(animation, child);
          },
        );

      case Routes.landing:
        Station? station = settings.arguments as Station?;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => serviceLocator<LandingBloc>()
              ..add(LandingLoadSites(context: context, station: station)),
            child: LandingPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _transitionBuilder(animation, child);
          },
        );

      case Routes.search:
        List<Station> stationList = settings.arguments as List<Station>;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => serviceLocator<LandingBloc>(),
            child: SearchPage(stationList: stationList),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _transitionBuilder(animation, child);
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static SlideTransition _transitionBuilder(
      Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}

class Routes {
  static const String splash = "splash";
  static const String login = "login";
  static const String landing = "landing";
  static const String search = "search";
}

import 'package:get_it/get_it.dart';
import 'package:sea_oil/blocs/landing/landing_bloc.dart';
import 'package:sea_oil/blocs/login/login_bloc.dart';
import 'package:sea_oil/networks/base_classes/account_service.dart';
import 'package:sea_oil/networks/base_classes/authentication_service.dart';
import 'package:sea_oil/networks/helpers/http_server_client.dart';
import 'package:sea_oil/networks/repositories/account_repository.dart';
import 'package:sea_oil/networks/repositories/authentication_repository.dart';

import 'networks/base_classes/navigation_service.dart';

final GetIt serviceLocator = GetIt.I;

Future setupLocator() async {
  serviceLocator.registerSingleton<HttpServerClient>(HttpServerClient());
  serviceLocator
      .registerLazySingleton<NavigationService>(() => NavigationService());
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  serviceLocator.registerLazySingleton<AccountService>(() => AccountService());

  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());
  serviceLocator
      .registerLazySingleton<AccountRepository>(() => AccountRepository());

  /// Bloc dependencies
  serviceLocator.registerFactory<LoginBloc>(() => LoginBloc());
  serviceLocator.registerFactory<LandingBloc>(() => LandingBloc());
}

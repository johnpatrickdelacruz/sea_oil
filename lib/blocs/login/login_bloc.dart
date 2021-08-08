import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/networks/abstract_repositories/authentication_repository_providing.dart';
import 'package:sea_oil/networks/helpers/connectivity_helper.dart';
import 'package:sea_oil/networks/helpers/errors.dart';
import 'package:sea_oil/networks/helpers/storage_helper.dart';
import 'package:sea_oil/networks/parsers/http_server_response.dart';
import 'package:sea_oil/networks/repositories/authentication_repository.dart';

import '../../locator.dart';
import 'login.export.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(initialState);

  static LoginState get initialState => LoginInitial();

  final AuthenticationRepositoryProviding _authenticationRepository =
      serviceLocator<AuthenticationRepository>();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUser) {
      yield* _mapLoginUserToState(
          username: event.username,
          password: event.password,
          context: event.context);
    }
  }

  Stream<LoginState> _mapLoginUserToState(
      {required String username,
      required String password,
      required BuildContext context}) async* {
    yield LoginProgress();

    if (!(await ConnectionHelper.hasConnection())) {
      yield LoginFailure(error: Errors.NoNetwork);
      return;
    }

    try {
      final HttpServerResponse response = await _authenticationRepository
          .loginUser(username: username, password: password);
      Navigator.pop(context);
      switch (response.status) {
        case 200:
          if (response.data['status'] == 'success') {
            StorageHelper.set(
                StorageKeys.access_token, response.data['data']['accessToken']);

            yield LoginUserSuccess();
          } else {
            yield LoginFailure(error: Errors.UserNotRegistered);
          }

          break;

        default:
          yield LoginFailure(error: Errors.Generic);
          break;
      }
    } catch (_) {
      yield LoginFailure(error: Errors.Generic);
    }
  }
}

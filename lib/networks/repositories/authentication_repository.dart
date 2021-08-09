import 'package:sea_oil/networks/abstract_repositories/authentication_repository_providing.dart';
import 'package:sea_oil/networks/base_classes/authentication_service.dart';
import 'package:sea_oil/networks/parsers/http_server_response.dart';

import '../../locator.dart';

class AuthenticationRepository extends AuthenticationRepositoryProviding {
  final AuthenticationService _authService =
      serviceLocator<AuthenticationService>();

  @override
  Future<HttpServerResponse> loginUser({username, password}) async =>
      await _authService.loginUser(username: username, password: password);
}

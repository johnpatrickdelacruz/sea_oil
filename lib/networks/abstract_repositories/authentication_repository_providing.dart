import 'package:flutter/material.dart';
import 'package:sea_oil/networks/parsers/http_server_response.dart';

abstract class AuthenticationRepositoryProviding {
  Future<HttpServerResponse> loginUser(
      {@required username, @required password});
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sea_oil/locator.dart';
import 'package:sea_oil/networks/helpers/http_server_client.dart';

import 'package:sea_oil/networks/endpoints.dart' as Endpoints;
import 'package:sea_oil/networks/parsers/http_server_response.dart';

class AuthenticationService {
  final client = serviceLocator<HttpServerClient>();

  Future<HttpServerResponse> loginUser(
      {@required username, @required password}) async {
    final HttpServerResponse response = HttpServerResponse();

    final url = Endpoints.login.login;
    final payload = {"mobile": username, "password": password};

    final resp = client.post(url, body: payload);

    await resp.then((res) {
      response.status = res.statusCode;
      response.data = res.data;
    }).catchError((e) {
      if (e is DioError) {
        final res = e.response;
        response.status = res!.statusCode;
      } else {
        response.status = 500;
        response.data = e;
      }
    });

    return response;
  }
}

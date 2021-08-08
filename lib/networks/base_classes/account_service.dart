import 'package:dio/dio.dart';
import 'package:sea_oil/locator.dart';
import 'package:sea_oil/networks/helpers/http_server_client.dart';

import 'package:sea_oil/networks/endpoints.dart' as Endpoints;
import 'package:sea_oil/networks/parsers/http_server_response.dart';
import 'package:sea_oil/networks/parsers/station_response.dart';

class AccountService {
  final client = serviceLocator<HttpServerClient>();

  Future<HttpServerResponse> getAllSites() async {
    final HttpServerResponse response = HttpServerResponse();

    final url = Endpoints.account.account_sites;

    final resp = client.get(url);

    await resp.then((res) {
      response.status = res.statusCode;
      switch (response.status) {
        case 200:
          response.data = StationResponse.fromJson(
            res.data,
          );
          break;
        default:
          break;
      }
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

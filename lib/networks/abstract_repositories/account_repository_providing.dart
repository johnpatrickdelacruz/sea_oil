import 'package:sea_oil/networks/parsers/http_server_response.dart';

abstract class AccountRepositoryProviding {
  Future<HttpServerResponse> loadSites();
}

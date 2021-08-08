import 'package:sea_oil/networks/abstract_repositories/account_repository_providing.dart';
import 'package:sea_oil/networks/base_classes/account_service.dart';

import 'package:sea_oil/networks/parsers/http_server_response.dart';

import '../../locator.dart';

class AccountRepository extends AccountRepositoryProviding {
  final AccountService _accountService = serviceLocator<AccountService>();

  @override
  Future<HttpServerResponse> loadSites() async =>
      await _accountService.getAllSites();
}

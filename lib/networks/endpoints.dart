final _auth = 'https://stable-api.pricelocq.com/mobile';

class _Login {
  final login = _auth + "/v2/sessions";
}

class _Account {
  final accountSites = _auth + "/stations?all";
}

final login = _Login();
final account = _Account();

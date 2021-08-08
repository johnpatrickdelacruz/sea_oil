class HttpServerResponse {
  HttpServerResponse({this.status, this.message, this.data});

  int? status = 400;
  String? message = "";
  dynamic data;
}

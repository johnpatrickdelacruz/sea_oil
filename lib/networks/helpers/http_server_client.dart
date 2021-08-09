import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sea_oil/networks/helpers/storage_helper.dart';

class HttpServerClient {
  late Dio _client;
  late Dio _clientLogin;

  HttpServerClient() {
    _clientLogin = new Dio();
    _client = new Dio(new BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
    ));

    _client.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      _attachAuthToken(options);

      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError error, handler) async {
      if (error.response?.statusCode == 403) {
        _client.interceptors.requestLock.lock();
        _client.interceptors.responseLock.lock();
      }

      return handler.next(error);
    }));
  }

  Future<RequestOptions> _attachAuthToken(RequestOptions options) async {
    final accessToken = await StorageHelper.get(StorageKeys.access_token);

    Map<String, dynamic> headers = {};
    headers['Content-Type'] = 'application/json;charset=UTF-8';
    if (accessToken != null) headers['Authorization'] = accessToken;
    // if (accessToken != null) headers['Authorization'] = 'Bearer $accessToken';
    options.headers = headers;

    return options;
  }

  Future<Response> get(String url) async {
    return _client.get(url);
  }

  Future<Response> patch(String url, {dynamic body}) async {
    return _client.patch(url, data: jsonEncode(body));
  }

  Future<Response> post(String url, {dynamic body}) async {
    return _client.post(url, data: body);
  }

  Future<Response> put(String url, {dynamic body}) async {
    return _client.put(url, data: body);
  }

  Future<Response> delete(String url, {dynamic body}) async {
    return _client.delete(url);
  }

  Future<Response> postLogin(String url, {dynamic body}) async {
    return _clientLogin.post(url, data: body);
  }
}

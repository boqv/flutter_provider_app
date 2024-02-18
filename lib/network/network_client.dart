import 'dart:convert';

import 'package:http/http.dart' as http;

import '../user_session/user_session.dart';

class NetworkClient {
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Map<String, String> _headers = {};

  final List<NetworkClientInterceptor> _interceptors = List.empty(growable: true);

  Future<http.Response> post(
      String url,
      Map<String, dynamic> body
  ) async {
    _headers = _defaultHeaders;

    for (var interceptor in _interceptors) {
      await interceptor.intercept(this);
    }

    return await http.post(
      Uri.parse(url),
      headers: _headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> get(
      String url,
      String? bearerToken
  ) async {
    _headers = _defaultHeaders;

    for (var interceptor in _interceptors) {
      await interceptor.intercept(this);
    }

    return await http.get(
      Uri.parse(url),
      headers: _headers,
    );
  }

  void addInterceptor(NetworkClientInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  void addHeader(Map<String, String> header) {
    _headers.addAll(header);
  }

  static NetworkClient factory(AuthenticationInterceptor authenticationInterceptor) {
    var networkClient = NetworkClient();
    networkClient.addInterceptor(authenticationInterceptor);

    return networkClient;
  }
}

abstract class NetworkClientInterceptor {
  Future<void> intercept(NetworkClient client);
}

class AuthenticationInterceptor implements NetworkClientInterceptor {
  final UserSession _userSession;

  AuthenticationInterceptor(this._userSession);

  @override
  Future<void> intercept(NetworkClient client) async {
    var token = await _userSession.authenticationToken;

    client.addHeader(
      { 'Authorization': 'Bearer $token' }
    );
  }
}
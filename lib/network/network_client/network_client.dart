import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:provider_app/network/network_client/network_client_exceptions.dart';

import '../../user_session/user_session.dart';

class NetworkClient {
  final http.Client client;

  final Duration _timeout = const Duration(seconds: 5);

  NetworkClient(this.client);
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

    final response = await client.post(
      Uri.parse(url),
      headers: _headers,
      body: jsonEncode(body),
    ).timeout(_timeout);

    return switch(response.statusCode) {
      (200) => response,
      (401) => throw NetworkClientUnauthorizedException(),
      _ => throw Exception("Unknown network error"),
    };
  }

  Future<http.Response> get(
      String url,
      String? bearerToken
  ) async {
    _headers = _defaultHeaders;

    for (var interceptor in _interceptors) {
      await interceptor.intercept(this);
    }

    final response = await http.get(
      Uri.parse(url),
      headers: _headers,
    ).timeout(_timeout);

    return switch(response.statusCode) {
      (200) => response,
      (401) => throw NetworkClientUnauthorizedException(),
      _ => throw Exception("Unknown network error"),
    };
  }

  void addInterceptor(NetworkClientInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  void addHeader(Map<String, String> header) {
    _headers.addAll(header);
  }

  static NetworkClient factory(AuthenticationInterceptor authenticationInterceptor) {
    var client = http.Client();
    var networkClient = NetworkClient(client);
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
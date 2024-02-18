import 'dart:convert';

import 'package:provider_app/network/network_client.dart';

import 'login_response.dart';

class LoginService {
  final NetworkClient _networkClient;

  LoginService(this._networkClient);

  Future<LoginResponse> login() async {
    final body = {
      'username': 'johan',
      'password': 'pass'
    };

    final response = await _networkClient.post('http://0.0.0.0:8080/login', body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>
      );
    }

    throw Exception("Something went wrong");
  }
}
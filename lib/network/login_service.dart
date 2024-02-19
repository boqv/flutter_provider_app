import 'dart:convert';

import 'package:provider_app/network/network_client/network_client.dart';

import '../config.dart';
import 'login_response.dart';

class LoginService {
  final NetworkClient _networkClient;

  LoginService(this._networkClient);

  Future<LoginResponse> login(String username, String password) async {
    final body = {
      'username': username,
      'password': password
    };

    final response = await _networkClient.post('${Config.baseUrl}/login', body);

    return LoginResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>
    );
  }
}
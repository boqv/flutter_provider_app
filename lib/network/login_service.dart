import 'dart:convert';

import 'package:provider_app/config.dart';
import 'package:provider_app/network/login_response.dart';
import 'package:provider_app/network/network_client/network_client.dart';

abstract class LoginServiceType {
  Future<LoginResponse> login(String username, String password);
}

class LoginService implements LoginServiceType {
  final NetworkClient _networkClient;

  LoginService(this._networkClient);

  @override
  Future<LoginResponse> login(String username, String password) async {
    final body = {
      'username': username,
      'password': password,
    };

    final response = await _networkClient.post('${Config.baseUrl}/login', body);

    return LoginResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

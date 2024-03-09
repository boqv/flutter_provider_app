import 'package:provider_app/network/login_response.dart';
import 'package:provider_app/network/login_service.dart';

class InMemoryLoginService implements LoginServiceType {
  LoginResponse response = const LoginResponse(token: "token");
  Exception? exception;
  bool didCallLogin = false;

  @override
  Future<LoginResponse> login(String username, String password) async {
    didCallLogin = true;

    if (exception case final exception?) {
      throw exception;
    }
    return response;
  }
}

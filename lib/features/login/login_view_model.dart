import 'package:flutter/foundation.dart';

import '../../network/login_service.dart';
import '../../user_session/user_session.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._userSession, this._loginService);
  final UserSession _userSession;
  final LoginService _loginService;

  String? _errorText;
  String? get errorText => _errorText;

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _errorText = "Please provide a username and password";
      notifyListeners();
      return false;
    }

    try {
      final token = await _loginService.login(username, password);

      if (kDebugMode) {
        print(token.token);
      }

      await _userSession.login(username, token.token);

      return true;
    } catch (exception) {
      _errorText = exception.toString();
      notifyListeners();

      return false;
    }
  }
}
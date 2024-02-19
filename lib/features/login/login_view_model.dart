import 'package:flutter/foundation.dart';

import '../../network/login_service.dart';
import '../../network/network_client/network_client_exceptions.dart';
import '../../user_session/user_session.dart';
import '../shared/error_dialog.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._userSession, this._loginService);
  final UserSession _userSession;
  final LoginService _loginService;

  String? _errorText;
  String? get errorText => _errorText;

  ViewError? _error;
  ViewError? get error => _error;

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _errorText = "Please provide a username and password";
      notifyListeners();
      return;
    }

    try {
      final token = await _loginService.login(username, password);
      await _userSession.login(username, token.token);
    } catch (exception) {
      switch (exception.runtimeType) {
        case NetworkClientUnauthorizedException:
          _errorText = "Wrong username or password";
          break;

      default:
        print(exception.toString());
        _error = ViewError("Error!", "Something unexpected happened!");
      }

      notifyListeners();
    }
  }
}
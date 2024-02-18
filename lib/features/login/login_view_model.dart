import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider_app/storage/secure_storage.dart';

import '../../network/login_service.dart';
import '../../user_session/user_session.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._userSession, this._loginService);
  final UserSession _userSession;
  final LoginService _loginService;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? _errorText;
  String? get errorText => _errorText;

  Future<bool> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      _errorText = "Please provide a username and password";
      notifyListeners();
      return false;
    }

    try {
      final token = await _loginService.login();

      if (kDebugMode) {
        print(token.token);
      }

      await _userSession.login(usernameController.text, token.token);

      return true;
    } catch (exception) {
      _errorText = exception.toString();
      notifyListeners();

      return false;
    }
  }
}
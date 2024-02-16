import 'package:flutter/cupertino.dart';

import '../../user_session/user_session.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._userSession);
  final UserSession _userSession;

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

    if (passwordController.text == "pass") {
      _userSession.login(usernameController.text);
      return true;
    } else {
      _errorText = "Wrong username or password";
      notifyListeners();
      return false;
    }
  }
}
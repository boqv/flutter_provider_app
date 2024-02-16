import 'package:flutter/cupertino.dart';

class UserSession extends ChangeNotifier {
  var _username = '';

  String get username => _username;
  bool get isLoggedIn => _username.isNotEmpty;

  void login(String username) {
    _username = username;
    notifyListeners();
  }

  void logout() {
    _username = '';
    notifyListeners();
  }
}
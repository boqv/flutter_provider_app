import 'package:flutter/cupertino.dart';
import 'package:provider_app/storage/secure_storage.dart';

class UserSession extends ChangeNotifier {
  final SecureStorageType _secureStorage;

  UserSession(this._secureStorage);

  var _username = '';

  String get username => _username;
  bool get isLoggedIn => _username.isNotEmpty;

  Future<String?> get authenticationToken async {
    return await _secureStorage.get("token");
  }

  Future<void> login(String username, String token) async {
    await _secureStorage.set("token", token);

    _username = username;
    notifyListeners();
  }

  void logout() {
    _username = '';
    notifyListeners();
  }
}
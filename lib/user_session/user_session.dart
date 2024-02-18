import 'package:flutter/cupertino.dart';
import 'package:provider_app/storage/secure_storage.dart';

class UserSession extends ChangeNotifier {
  final SecureStorageType _secureStorage;

  UserSession(this._secureStorage) {
    configure();
  }

  Future<void> configure() async {
    _isLoggedIn = await authenticationToken != null;

    notifyListeners();
  }

  var _username = '';

  String get username => _username;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<String?> get authenticationToken async {
    return await _secureStorage.get("token");
  }

  Future<void> login(String username, String token) async {
    await _secureStorage.set("token", token);

    _username = username;
    _isLoggedIn = true;

    notifyListeners();
  }

  void logout() async {
    _username = '';
    await _secureStorage.delete("token");

    _isLoggedIn = false;
    notifyListeners();
  }
}
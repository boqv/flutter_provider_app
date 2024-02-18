import 'package:flutter/cupertino.dart';
import 'package:provider_app/storage/secure_storage.dart';

class UserSession extends ChangeNotifier {
  final SecureStorageType _secureStorage;

  UserSession(this._secureStorage) {
    configure();
  }

  Future<void> configure() async {
    if (await authenticationToken != null) {
      _state = UserSessionState.loggedIn;
    }

    notifyListeners();
  }

  var _username = '';

  String get username => _username;

  UserSessionState _state = UserSessionState.loggedOut;
  UserSessionState get state => _state;

  Future<String?> get authenticationToken async {
    return await _secureStorage.get("token");
  }

  Future<void> login(String username, String token) async {
    await _secureStorage.set("token", token);

    _username = username;
    _state = UserSessionState.loggedIn;

    notifyListeners();
  }

  Future<void> sessionExpired() async {
    _state = UserSessionState.expired;
    notifyListeners();
  }

  Future<void> logout() async {
    _username = '';
    await _secureStorage.delete("token");

    _state = UserSessionState.loggedOut;
    notifyListeners();
  }
}

enum UserSessionState {
  loggedIn,
  expired,
  loggedOut
}
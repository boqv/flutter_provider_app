import 'package:flutter/cupertino.dart';
import 'package:provider_app/storage/secure_storage.dart';

import '../storage/key_value_store.dart';

class UserSession extends ChangeNotifier {
  final SecureStorageType _secureStorage;
  final KeyValueStoreType _keyValueStore;

  UserSession(this._secureStorage, this._keyValueStore) {
    configure();
  }

  Future<void> configure() async {
    if (await authenticationToken != null) {
      _state = UserSessionState.loggedIn;
      _username = await _keyValueStore.get("username") ?? "";

      notifyListeners();
    }
  }

  String _username = "";
  String get username => _username;

  UserSessionState _state = UserSessionState.loggedOut;
  UserSessionState get state => _state;

  Future<String?> get authenticationToken async {
    return await _secureStorage.get("token");
  }

  Future<void> login(String username, String token) async {
    await _secureStorage.set("token", token);
    await _keyValueStore.set("username", username);
    _username = username;
    _state = UserSessionState.loggedIn;

    notifyListeners();
  }

  Future<void> sessionExpired() async {
    _state = UserSessionState.expired;
    notifyListeners();
  }

  Future<void> logout() async {
    await _keyValueStore.delete("username");
    await _secureStorage.delete("token");

    _state = UserSessionState.loggedOut;
    _username = "";
    notifyListeners();
  }
}

enum UserSessionState {
  loggedIn,
  expired,
  loggedOut
}
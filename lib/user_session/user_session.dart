import 'package:flutter/cupertino.dart';
import 'package:provider_app/storage/key_value_store.dart';
import 'package:provider_app/storage/secure_storage.dart';

abstract class UserSessionType {
  Future<void> configure();
  Future<void> login(String username, String token);
  Future<void> sessionExpired();
  Future<void> logout();

  String get username;
}

class UserSession extends ChangeNotifier implements UserSessionType {
  final SecureStorageType _secureStorage;
  final KeyValueStoreType _keyValueStore;

  UserSession(this._secureStorage, this._keyValueStore) {
    configure();
  }

  @override
  Future<void> configure() async {
    final token = await authenticationToken;
    if (token != null && token.isNotEmpty) {
      _state = UserSessionState.loggedIn;
      _username = await _keyValueStore.get("username") ?? "";

      notifyListeners();
    }
  }

  String _username = "";
  @override
  String get username => _username;

  UserSessionState _state = UserSessionState.loggedOut;
  UserSessionState get state => _state;

  Future<String?> get authenticationToken async {
    return await _secureStorage.get("token");
  }

  @override
  Future<void> login(String username, String token) async {
    await _secureStorage.set("token", token);
    await _keyValueStore.set("username", username);
    _username = username;
    _state = UserSessionState.loggedIn;

    notifyListeners();
  }

  @override
  Future<void> sessionExpired() async {
    _state = UserSessionState.expired;
    notifyListeners();
  }

  @override
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

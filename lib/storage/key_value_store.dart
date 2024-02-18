import 'package:shared_preferences/shared_preferences.dart';

abstract class KeyValueStoreType {
  Future<void> set(String key, String value);

  Future<String?> get(String key);

  Future<void> delete(String key);
}

class KeyValueStore implements KeyValueStoreType {
  KeyValueStore(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> set(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> get(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _sharedPreferences.remove(key);
  }
}
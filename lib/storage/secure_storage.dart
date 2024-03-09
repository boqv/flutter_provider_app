import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageType {
  Future<void> set(String key, String value);
  Future<String?> get(String key);
  Future<void> delete(String key);
}

class SecureStorage implements SecureStorageType {
  const SecureStorage({required this.storage});

  final FlutterSecureStorage storage;

  AndroidOptions get _aOptions => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  IOSOptions get _iOptions => const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock
  );

  @override
  Future<void> set(String key, String value) async {
    await storage.write(key: key, value: value, iOptions: _iOptions, aOptions: _aOptions);
  }

  @override
  Future<String?> get(String key) async {
    return await storage.read(key: key, iOptions: _iOptions, aOptions: _aOptions);
  }

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key, iOptions: _iOptions, aOptions: _aOptions);
  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageType {
  Future<void> set(String key, String value);
  Future<String?> get(String key);
}

class SecureStorage implements SecureStorageType {
  const SecureStorage({required this.storage});

  final FlutterSecureStorage storage;

  final AndroidOptions _aOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final IOSOptions iOptions = const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock
  );

  @override
  Future<void> set(String key, String value) async {
    const iOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    await storage.write(key: key, value: value, iOptions: iOptions, aOptions: _aOptions);
  }

  @override
  Future<String?> get(String key) async {
    return await storage.read(key: key, iOptions: iOptions, aOptions: _aOptions);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/features/expired_session/expired_session_screen.dart';
import 'package:provider_app/routing/app_route.dart';
import 'package:provider_app/storage/key_value_store.dart';
import 'package:provider_app/storage/secure_storage.dart';
import 'package:provider_app/user_session/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection/dependency_injection.dart';
import 'features/home/home_screen.dart';
import 'features/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureUserSession();

  runApp(const MyApp());
}

Future<void> configureUserSession() async {
  _sharedPreferences = await SharedPreferences.getInstance();
  _userSession = UserSession(
      const SecureStorage(storage: FlutterSecureStorage()),
      KeyValueStore(_sharedPreferences)
  );
}

late final UserSession _userSession;
late final SharedPreferences _sharedPreferences;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...storage(_sharedPreferences),
        ...userSession(_userSession),
        ...network,
      ],
      child: MaterialApp.router(
        routerConfig: router(_userSession),
      )
    );
  }
}




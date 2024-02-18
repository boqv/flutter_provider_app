import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/features/expired_session/expired_session_screen.dart';
import 'package:provider_app/storage/secure_storage.dart';
import 'package:provider_app/user_session/user_session.dart';

import 'dependency_injection/dependency_injection.dart';
import 'features/home/home_screen.dart';
import 'features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: '/expired',
      builder: (context, state) => const ExpiredSessionScreen(),
    ),
    GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
    ),
  ],
  refreshListenable: _userSession,
  redirect: (context, state) {
    if (_userSession.state == UserSessionState.loggedOut) {
      return '/login';
    }

    if (_userSession.state == UserSessionState.expired) {
      return '/expired';
    }

    return '/home';
  }
);

final _userSession = UserSession(
  const SecureStorage(storage: FlutterSecureStorage())
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _userSession),
        ...network,
        ...viewModels
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      )
    );
  }
}




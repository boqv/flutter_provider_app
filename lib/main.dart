import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/user_session/user_session.dart';

import 'features/home/home_screen.dart';
import 'features/login/login_screen.dart';
import 'features/login/login_view_model.dart';

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
        path: '/home',
        builder: (context, state) => const HomeScreen()
    ),
  ],
  refreshListenable: userSession,
  redirect: (context, state) {
    if (!userSession.isLoggedIn) {
      return '/login';
    }

    return '/home';
  }
);

final userSession = UserSession();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(userSession)
        ),
        ChangeNotifierProvider<UserSession>(
          create: (context) => userSession
        )
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      )
    );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_app/routing/routes.dart';

import '../features/expired_session/expired_session_screen.dart';
import '../features/home/home_screen.dart';
import '../features/login/login_screen.dart';
import '../user_session/user_session.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router(UserSession userSession) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    routes: [
      GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen(),
          parentNavigatorKey: _rootNavigatorKey
      ),
      GoRoute(
          path: Routes.expired,
          builder: (context, state) => const ExpiredSessionScreen(),
          parentNavigatorKey: _rootNavigatorKey
      ),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return HomeScreen(child: child);
          },
          routes: [
            GoRoute(
                path: Routes.home,
                builder: (context, state) {
                  return const Text("home!");
                },
                parentNavigatorKey: _shellNavigatorKey
            ),
            GoRoute(
                path: Routes.tools,
                builder: (context, state) {
                  return const Text("tools!");
                },
                parentNavigatorKey: _shellNavigatorKey
            )
          ]
      ),
    ],
    refreshListenable: userSession,
    redirect: (context, state) {
      if (userSession.state == UserSessionState.loggedOut) {
        return Routes.login;
      }

      if (userSession.state == UserSessionState.expired) {
        return Routes.expired;
      }

      if (state.matchedLocation == Routes.login) {
        return Routes.home;
      }
    }
);
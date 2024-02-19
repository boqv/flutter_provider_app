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
    initialLocation: AppRoute.home,
    routes: [
      GoRoute(
          path: AppRoute.login,
          builder: (context, state) => const LoginScreen(),
          parentNavigatorKey: _rootNavigatorKey
      ),
      GoRoute(
          path: AppRoute.expired,
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
                path: AppRoute.home,
                builder: (context, state) {
                  return const Text("home!");
                },
                parentNavigatorKey: _shellNavigatorKey
            ),
            GoRoute(
                path: AppRoute.tools,
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
        return AppRoute.login;
      }

      if (userSession.state == UserSessionState.expired) {
        return AppRoute.expired;
      }

      if (state.matchedLocation == AppRoute.login) {
        return AppRoute.home;
      }
    }
);
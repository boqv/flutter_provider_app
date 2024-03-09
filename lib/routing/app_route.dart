import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_app/features/expired_session/expired_session_screen.dart';
import 'package:provider_app/features/login/login_screen.dart';
import 'package:provider_app/features/root/deliveries/deliveries_screen.dart';
import 'package:provider_app/features/root/home/home_screen.dart';
import 'package:provider_app/features/root/root_screen.dart';
import 'package:provider_app/features/tools/tools_screen.dart';
import 'package:provider_app/routing/routes.dart';
import 'package:provider_app/user_session/user_session.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router(UserSession userSession) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: AppRoute.login,
          builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
          path: AppRoute.expired,
          builder: (context, state) => const ExpiredSessionScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RootScreen(child: navigationShell);
        },
        branches: [
          StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.home,
                  builder: (context, state) {
                    return const HomeScreen();
                  },
                ),
              ],
          ),
          StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.news,
                  builder: (context, state) {
                    return const DeliveriesScreen();
                  },
                ),
              ],
          ),
          StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.tools,
                  builder: (context, state) {
                    return const ToolsScreen();
                  },
                ),
              ],
          ),
        ],
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

      return null;
    },
);

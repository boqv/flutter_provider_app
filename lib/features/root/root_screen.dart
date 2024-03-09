import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider_app/routing/routes.dart';

class RootScreen extends StatelessWidget {
  final Widget child;
  const RootScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return _Content(child);
  }
}

class _Content extends StatelessWidget {
  final Widget _child;

  const _Content(this._child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder title'),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        toolbarHeight: 20,
      ),
      bottomNavigationBar: _BottomNavigation(),
      body: _child,
    );
  }
}

class _BottomNavigation extends StatefulWidget {
  @override _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<_BottomNavigation> {
  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: const<BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex(context),
      onTap: (index) {
        _navigate(context, index);
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
      selectedItemColor: Colors.yellow,
    );
  }

  int _selectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(AppRoute.home)) {
      return 0;
    }
    if (location.startsWith(AppRoute.news)) {
      return 1;
    }
    if (location.startsWith(AppRoute.tools)) {
      return 2;
    }
    return 0;
  }

  void _navigate(BuildContext context, int index) {
    switch(index) {
      case 0: context.go(AppRoute.home);
      case 1: context.go(AppRoute.news);
      case 2: context.go(AppRoute.tools);
      default:
    }
  }
}

/*
class _Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.amber),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      'Hello!',
                      style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
              context.go('/home');
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
              context.go('/tools');
            },
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
*/

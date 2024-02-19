import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/features/home/home_view_model.dart';
import 'package:provider_app/network/items_service.dart';
import 'package:provider_app/user_session/user_session.dart';

import '../shared/error_dialog.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          context.read<UserSession>(),
          context.read<ItemsService>()
      ),
      child: _Content(child),
    );
  }


}
class _Content extends StatelessWidget {
  final Widget _child;

  const _Content(this._child);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewModel>();

    if (viewModel.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorDialog(context, viewModel.error!);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Placeholder title'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
      drawer: Drawer(
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
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                    Text(
                      (viewModel.username ?? ""),
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                )
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
                viewModel.logout();
              },
            ),
          ],
        ),
      ),
      body: _child,
    );
  }
}
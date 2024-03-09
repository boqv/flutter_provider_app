import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/user_session/user_session.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userSession = context.read<UserSession>();
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tools',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                  "I don't know what to put here yet",
                  style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              userSession.logout();
            },
            child: const Text('LOGOUT'),
        ),
      ],
    )
    );
  }
}

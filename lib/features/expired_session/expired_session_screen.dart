import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_app/user_session/user_session.dart';

class ExpiredSessionScreen extends StatelessWidget {
  const ExpiredSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userSession = context.read<UserSession>();

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            children: [
              const Text("Your session has expired. Please log in again."),
              ElevatedButton(
                  onPressed: () {
                    userSession.logout();
                  },
                  child: const Text('LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

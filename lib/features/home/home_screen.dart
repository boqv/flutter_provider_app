import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user_session/user_session.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userSession = context.read<UserSession>();
    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  children: [
                    const Text("Home"),
                    Text("Welcome, ${userSession.username}"),
                    ElevatedButton(
                        onPressed: () {
                          userSession.logout();
                        },
                        child: const Text('LOGOUT')
                    )
                  ],
                )
            )
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/features/home/home_view_model.dart';
import 'package:provider_app/storage/secure_storage.dart';

import '../../user_session/user_session.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewModel>();

    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  children: [
                    const Text("Home"),
                    Text("Welcome, ${viewModel.username}"),
                    const SizedBox(height: 40),
                    Column(
                      children: viewModel.items.map((item) {
                        return Text(item);
                      }).toList(),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.logout();
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
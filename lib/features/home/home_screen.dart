import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/features/home/home_view_model.dart';
import 'package:provider_app/network/items_service.dart';
import 'package:provider_app/user_session/user_session.dart';

import '../shared/error_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          context.read<UserSession>(),
          context.read<ItemsService>()
      ),
      child: _Content(),
    );
  }


}
class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewModel>();

    if (viewModel.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorDialog(context, viewModel.error!);
      });
    }

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
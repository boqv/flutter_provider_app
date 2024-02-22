import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/network/items_service.dart';
import 'package:provider_app/user_session/user_session.dart';

import '../../shared/error_dialog.dart';
import 'home_view_model.dart';


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

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Home",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                  "This page fetches stuff!",
                  style: Theme.of(context).textTheme.labelLarge
              ),
            ],
          ),
        ),
        Column(
            children: viewModel.items.map((item) {
              return Text(item);
            }
            ).toList()
        )
      ],
    );
  }
}
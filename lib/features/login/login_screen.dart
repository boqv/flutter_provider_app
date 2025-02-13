import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/features/login/login_view_model.dart';
import 'package:provider_app/features/shared/error_dialog.dart';
import 'package:provider_app/network/login_service.dart';
import 'package:provider_app/user_session/user_session.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
        context.read<UserSession>(),
        context.read<LoginService>(),
      ),
      child: _ContentContainer(),
    );
  }
}

class _ContentContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(64.0),
                child: _Content(),
            ),
        ),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    return viewModel.isLoading ? _Loading() : _LoginContainer();
  }
}

class _LoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Header(),
        const SizedBox(height: 32),
        _Form(),
      ],
    );
  }

}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'Welcome',
            style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
            'Please login',
            style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
    );
  }

}

class _Form extends StatefulWidget {
  @override _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    if (viewModel.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        errorDialog(context, viewModel.error!);
      });
    }

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Username',
                style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextFormField(
              controller: usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
                'Password',
                style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextFormField(
              decoration: InputDecoration(
                errorText: viewModel.errorText,
              ),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await viewModel.login(
                        usernameController.text,
                        passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                  ),
                  child: const Text('LOGIN'),
                ),
            ),
          ],
        ),
    );
  }
}

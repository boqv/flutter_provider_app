import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider_app/features/login/login_view_model.dart';
import 'package:provider_app/features/shared/error_dialog.dart';
import 'package:provider_app/network/network_client/network_client_exceptions.dart';

import '../../network/in_memory_login_service.dart';
import '../../user_session/in_memory_user_session.dart';

void main() {
  late InMemoryUserSession userSession;
  late InMemoryLoginService loginService;
  late LoginViewModel viewModel;
  
  setUp(() {
    userSession = InMemoryUserSession();
    loginService = InMemoryLoginService();
    viewModel = LoginViewModel(userSession, loginService);
  });

  test('login with empty username', () async {
    await viewModel.login("", "password");

    expect(viewModel.errorText?.isNotEmpty, true);
    expect(loginService.didCallLogin, false);
  });

  test('login with empty username', () async {
    await viewModel.login("", "password");

    expect(viewModel.errorText?.isNotEmpty, true);
    expect(loginService.didCallLogin, false);
  });

  test('login with unauthorized exception', () async {
    loginService.exception = NetworkClientUnauthorizedException();

    await viewModel.login("username", "password");

    expect(viewModel.errorText,"Wrong username or password");
    expect(loginService.didCallLogin, true);
  });

  test('login with timeout exception', () async {
    loginService.exception = TimeoutException("message");

    await viewModel.login("username", "password");

    expect(viewModel.error, ViewError("Network error", "Request timed out."));
    expect(loginService.didCallLogin, true);
  });

  test('login with unknown exception', () async {
    loginService.exception = Exception();

    await viewModel.login("username", "password");

    expect(
        viewModel.error,
        ViewError("Network error", "Something unexpected happened!"),
    );
    expect(loginService.didCallLogin, true);
  });

  test('login with username and password', () async {
    await viewModel.login("username", "password");

    expect(viewModel.errorText, null);
    expect(loginService.didCallLogin, true);
  });
}

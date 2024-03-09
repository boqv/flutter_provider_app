import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:provider_app/features/shared/error_dialog.dart';
import 'package:provider_app/network/login_service.dart';
import 'package:provider_app/network/network_client/network_client_exceptions.dart';
import 'package:provider_app/user_session/user_session.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._userSession, this._loginService);
  final UserSessionType _userSession;
  final LoginServiceType _loginService;

  String? _errorText;
  String? get errorText => _errorText;

  ViewError? _error;
  ViewError? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    _resetErrors();

    if (username.isEmpty || password.isEmpty) {
      _errorText = "Please provide a username and password";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final token = await _loginService.login(username, password);
      await _userSession.login(username, token.token);
    } catch (exception) {
      _isLoading = false;

      switch (exception.runtimeType) {
        case const (NetworkClientUnauthorizedException):
          _errorText = "Wrong username or password";

        case const (TimeoutException):
          _error = ViewError("Network error", "Request timed out.");

      default:
        _error = ViewError("Network error", "Something unexpected happened!");
      }

      notifyListeners();
    }
  }

  void _resetErrors() {
    _error = null;
    _errorText = null;
  }
}

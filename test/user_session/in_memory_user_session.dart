import 'package:provider_app/user_session/user_session.dart';

class InMemoryUserSession implements UserSessionType {
  @override
  Future<void> configure() async {

  }

  @override
  Future<void> login(String username, String token) async {
    return;
  }

  @override
  Future<void> logout() async {

  }

  @override
  Future<void> sessionExpired() async {

  }

  final _username = "";

  @override
  String get username => _username;
}

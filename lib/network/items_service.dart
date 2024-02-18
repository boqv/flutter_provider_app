import 'dart:convert';

import 'package:provider_app/user_session/user_session.dart';

import '../features/home/home_view_model.dart';
import 'network_client/network_client.dart';

class ItemsService {
  final UserSession _userSession;
  final NetworkClient _networkClient;

  ItemsService(this._userSession, this._networkClient);

  Future<ItemsResponse> getItems() async {
    var token = await _userSession.authenticationToken;

    var response = await _networkClient.get(
        'http://0.0.0.0:8080/items',
        token
    );

    return ItemsResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
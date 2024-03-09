import 'dart:convert';

import 'package:provider_app/config.dart';
import 'package:provider_app/features/root/home/home_view_model.dart';
import 'package:provider_app/network/network_client/network_client.dart';
import 'package:provider_app/user_session/user_session.dart';

abstract class ItemsServiceType {
  Future<ItemsResponse> getItems();
}

class ItemsService implements ItemsServiceType {
  final UserSession _userSession;
  final NetworkClient _networkClient;

  ItemsService(this._userSession, this._networkClient);

  @override
  Future<ItemsResponse> getItems() async {
    final token = await _userSession.authenticationToken;

    final response = await _networkClient.get(
        '${Config.baseUrl}/items',
        token,
    );

    return ItemsResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

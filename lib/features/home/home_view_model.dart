import 'package:flutter/cupertino.dart';

import '../../network/items_service.dart';
import '../../network/network_client/network_client_exceptions.dart';
import '../../user_session/user_session.dart';
import '../shared/error_dialog.dart';

class HomeViewModel extends ChangeNotifier {
  final UserSession _userSession;
  final ItemsService _itemsService;

  HomeViewModel(this._userSession, this._itemsService);

  List<String> _items = List.empty();
  List<String> get items => _items;

  ViewError? _error;
  ViewError? get error => _error;

  String? get username => _userSession.username;

  Future<void> getItems() async {
    try {
      var response = await _itemsService.getItems();
      _items = response.items;
      notifyListeners();
    } catch (exception) {
      switch (exception.runtimeType) {
        case NetworkClientUnauthorizedException:
          _userSession.sessionExpired();
          break;

        default:
          _error = ViewError("Error!", "Something unexpected happened!");
          notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    await _userSession.logout();
  }
}

class ItemsResponse {
  final List<String> items;

  const ItemsResponse({ required this.items });

  factory ItemsResponse.fromJson(Map<String, dynamic> json) {
    var items = List<String>.from(json['items']);
    return ItemsResponse(items: items);
  }
}
import 'package:flutter/cupertino.dart';

import '../../network/items_service.dart';
import '../../user_session/user_session.dart';

class HomeViewModel extends ChangeNotifier {
  final UserSession _userSession;
  final ItemsService _itemsService;

  HomeViewModel(this._userSession, this._itemsService);

  List<String> _items = List.empty();
  List<String> get items => _items;

  String get username => _userSession.username;

  Future<void> getItems() async {
    var response = await _itemsService.getItems();
    _items = response.items;
    notifyListeners();
  }

  Future<void> logout() async {
    _userSession.logout();
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
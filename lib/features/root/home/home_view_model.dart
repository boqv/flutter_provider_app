import 'package:flutter/cupertino.dart';
import 'package:provider_app/features/shared/error_dialog.dart';
import 'package:provider_app/network/items_service.dart';
import 'package:provider_app/network/network_client/network_client_exceptions.dart';
import 'package:provider_app/user_session/user_session.dart';

class HomeViewModel extends ChangeNotifier {
  final UserSessionType _userSession;
  final ItemsServiceType _itemsService;

  HomeViewModel(this._userSession, this._itemsService) {
    getItems();
  }

  List<String> _items = List.empty();
  List<String> get items => _items;

  ViewError? _error;
  ViewError? get error => _error;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String? get username => _userSession.username;

  Future<void> getItems() async {
    try {
      final response = await _itemsService.getItems();
      _items = response.items;
      notifyListeners();
    } catch (exception) {
      switch (exception.runtimeType) {
        case const (NetworkClientUnauthorizedException):
          _userSession.sessionExpired();

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
    final items = (json['items'] as List<dynamic>)
        .map((item) => item.toString())
        .toList();
    return ItemsResponse(items: items);
  }
}

class ItemsResponseListItem {
  const ItemsResponseListItem({ required this.title});
  final String title;
}

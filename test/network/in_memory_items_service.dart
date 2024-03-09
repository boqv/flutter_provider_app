import 'package:provider_app/features/root/home/home_view_model.dart';
import 'package:provider_app/network/items_service.dart';

class InMemoryItemsService implements ItemsServiceType {
  ItemsResponse response = const ItemsResponse(items: []);

  @override
  Future<ItemsResponse> getItems() async {
    return response;
  }
}

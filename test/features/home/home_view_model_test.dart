import 'package:flutter_test/flutter_test.dart';
import 'package:provider_app/features/root/home/home_view_model.dart';

import '../../network/in_memory_items_service.dart';
import '../../user_session/in_memory_user_session.dart';

void main() {
  late InMemoryUserSession userSession;
  late InMemoryItemsService itemsService;
  late HomeViewModel viewModel;

  setUp(
    () {
      userSession = InMemoryUserSession();
      itemsService = InMemoryItemsService();
      viewModel = HomeViewModel(userSession, itemsService);
    },
  );

  test("getItems with response", () async {
    itemsService.response = const ItemsResponse(items: ["one", "two", "three"]);

    await viewModel.getItems();

    expect(viewModel.items, ["one", "two", "three"]);
  });
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider_app/features/root/root_navigation_state.dart';
import 'package:provider_app/user_session/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/items_service.dart';
import '../network/login_service.dart';
import '../network/network_client/network_client.dart';
import '../storage/key_value_store.dart';
import '../storage/secure_storage.dart';

/* User session dependencies */
List<SingleChildWidget> userSession(UserSession userSession) => [
  ChangeNotifierProvider.value(value: userSession)
];

/* Storage dependencies */
List<SingleChildWidget> storage(SharedPreferences sharedPreferences) => [
  Provider<SecureStorageType>(
    create: (context) => const SecureStorage(storage: FlutterSecureStorage()),
  ),
  Provider<KeyValueStoreType>(
    create: (context) => KeyValueStore(sharedPreferences),
  ),
];

/* Network related dependencies */
final List<SingleChildWidget> network = [
  Provider<AuthenticationInterceptor>(
    create: (context) => AuthenticationInterceptor(context.read<UserSession>())
  ),
  Provider<NetworkClient>(
    create: (context) => NetworkClient.factory(
        context.read<AuthenticationInterceptor>()
    )
  ),
  Provider<LoginService>(
    create: (context) => LoginService(context.read<NetworkClient>()),
  ),
  Provider<ItemsService>(
      create: (context) => ItemsService(context.read<UserSession>(), context.read<NetworkClient>())
  ),
];

/* Misc dependencies */
final List <SingleChildWidget> misc = [
  ChangeNotifierProvider(
      create: (context) => RootNavigationState()
  )
];
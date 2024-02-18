import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider_app/user_session/user_session.dart';

import '../features/home/home_view_model.dart';
import '../features/login/login_view_model.dart';
import '../network/items_service.dart';
import '../network/login_service.dart';
import '../network/network_client/network_client.dart';

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

/* ViewModel dependencies */
final List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
          context.read<UserSession>(),
          context.read<LoginService>()
      )
  ),
  ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          context.read<UserSession>(),
          context.read<ItemsService>()
      )
  ),
];
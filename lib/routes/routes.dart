import 'package:auth_jwt/modules/login/login_router.dart';
import 'package:auth_jwt/routes/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

class Routes {
  final Router _router = Router();
  final List<IRouter> routes = [
    SecurityRouter(),
  ];

  Router get router {
    for (IRouter route in routes) {
      route.configure(_router);
    }

    return _router;
  }
}

import 'package:auth_jwt/modules/login/controller/login_controller.dart';
import 'package:auth_jwt/routes/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

class SecurityRouter implements IRouter {
  @override
  void configure(Router router) {
    final LoginController testController = LoginController.instance;

    router.mount('/auth', testController.configure(router).call);
  }
}

import 'dart:convert';

import 'package:auth_jwt/core/controller/i_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class SecurityController implements IController {
  SecurityController._();

  static final SecurityController _instance = SecurityController._();
  static SecurityController get instance => _instance;

  @override
  Router configure(Router router) {
    router.get('/login', login);

    return router;
  }

  Future<Response> login(Request request) async {
    return Response.ok(jsonEncode({'message': 'deu certo'}));
  }
}

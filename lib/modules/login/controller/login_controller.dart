import 'dart:convert';

import 'package:auth_jwt/core/controller/i_controller.dart';
import 'package:auth_jwt/core/logger/logger.dart';
import 'package:auth_jwt/entities/user_entity.dart';
import 'package:auth_jwt/helpers/jwt_helper.dart';
import 'package:auth_jwt/modules/login/data/login_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginController implements IController {
  LoginController._();

  static final LoginController _instance = LoginController._();
  static LoginController get instance => _instance;

  final LoginRepository repository = LoginRepository.instance;
  final Logger log = Logger.instance;

  @override
  Router configure(Router router) {
    router.get('/login', login);
    router.get('/register', register);
    router.get('/confirm', confirmLogin);

    return router;
  }

  Future<Response> login(Request request) async {
    try {
      final String requestString = await request.readAsString();
      final Map<String, dynamic> data = jsonDecode(requestString);

      final String email = data['email'];
      final String password = data['password'];

      final UserEntity? user = repository.login(email: email, password: password);

      if (user == null) {
        throw Exception();
      }

      final String accessToken = JwtHelper.generateJwtToken(
        userId: user.id,
        email: email,
      );

      return Response.ok(jsonEncode({
        'access_token': accessToken,
      }));
    } on Exception catch (e, s) {
      log.error(message: 'Error while logging', error: e, stackTrace: s);
      return Response.notFound(jsonEncode({'message': 'user not found'}));
    }
  }

  Future<Response> confirmLogin(Request request) async {
    return Response.ok(jsonEncode({}));
  }

  Future<Response> register(Request request) async {
    return Response.ok(jsonEncode({'message': 'registro'}));
  }
}

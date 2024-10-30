import 'dart:convert';

import 'package:auth_jwt/core/logger/logger.dart';
import 'package:auth_jwt/core/middleware/i_middleware.dart';
import 'package:auth_jwt/helpers/jwt_helper.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

class SecurityMiddleware extends IMiddleware {
  final Logger log = Logger.instance;

  final Map<String, String> passUrls = {
    'auth/register': 'POST',
    'auth/login': 'GET',
  };

  @override
  Future<Response> requestHandler(Request request) async {
    try {
      /* Pulando a verifação */
      final String? passUrl = passUrls[request.url.path];

      if (passUrl != null && request.method == passUrl) {
        return innerHandler(request);
      }

      /* Verificando o header de authorization */
      final String? accessToken = request.headers['Authorization'];
      if (accessToken == null || accessToken.isEmpty) {
        throw Exception();
      }

      final List<String> tokenSplit = accessToken.split(' ');
      if (tokenSplit.length != 2 || !tokenSplit[0].contains('Bearer')) {
        throw Exception();
      }

      /* Validando token */
      final String token = tokenSplit[1];
      JwtHelper.verifyToken(token: token);

      JWT decodedToken = JWT.decode(token);

      if (request.url.path == 'auth/refresh') {
        final String refreshToken = decodedToken.payload['sub']!;
        final String accessToken = refreshToken.split(' ')[1];
        decodedToken = JWT.decode(accessToken);
      }

      final Map<String, dynamic> headers = {
        'user_id': decodedToken.payload['sub'],
        'email': decodedToken.payload['email'],
      };

      return innerHandler(request.change(headers: headers));
    } on Exception catch (e, s) {
      log.error(message: 'Invalid Token', error: e, stackTrace: s);
      return Response.forbidden(jsonEncode({
        'message': 'invalid token',
      }));
    }
  }
}

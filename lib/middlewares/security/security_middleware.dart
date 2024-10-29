import 'dart:convert';

import 'package:auth_jwt/core/middleware/i_middleware.dart';
import 'package:auth_jwt/helpers/jwt_helper.dart';
import 'package:shelf/shelf.dart';

class SecurityMiddleware extends IMiddleware {
  @override
  Future<Response> requestHandler(Request request) async {
    try {
      /* Pulando a verifação */
      if ((request.method == 'POST' && request.url.path == 'auth/register') || (request.method == 'GET' && request.url.path == 'auth/login')) {
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

      final String token = tokenSplit[1];
      JwtHelper.verifyToken(token: token);

      return innerHandler(request);
    } on Exception {
      return Response.forbidden(jsonEncode({
        'message': 'invalid token',
      }));
    }
  }
}

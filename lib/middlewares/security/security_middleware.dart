import 'dart:convert';

import 'package:auth_jwt/core/middleware/i_middleware.dart';
import 'package:shelf/shelf.dart';

class SecurityMiddleware extends IMiddleware {
  @override
  Future<Response> requestHandler(Request request) async {
    /* Pulando a verifação */
    if (request.method == 'GET' && request.url.path == '/auth/register') {
      return innerHandler(request);
    }

    /* Verificando o header de authorization */
    final String? accessToken = request.headers['Authorization'];

    if (accessToken == null || accessToken.isEmpty || !accessToken.contains('Bearer ')) {
      return Response.forbidden(jsonEncode({
        'message': 'invalid token',
      }));
    }
  }
}

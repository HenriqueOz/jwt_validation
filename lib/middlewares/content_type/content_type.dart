import 'package:auth_jwt/core/middleware/i_middleware.dart';
import 'package:shelf/shelf.dart';

class ContentType extends IMiddleware {
  final Map<String, String> headers = {
    'content-type': 'application/json;charset=utf-8',
  };

  @override
  Future<Response> requestHandler(Request request) async {
    final Response response = await innerHandler(request);

    return response.change(headers: headers);
  }
}

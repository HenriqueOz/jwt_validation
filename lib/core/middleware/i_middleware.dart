import 'package:shelf/shelf.dart';

abstract class IMiddleware {
  late Handler innerHandler;

  Handler handler(Handler handler) {
    innerHandler = handler;
    return requestHandler;
  }

  Future<Response> requestHandler(Request request);
}

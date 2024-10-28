import 'dart:async';
import 'dart:io';

import 'package:auth_jwt/core/env/env.dart';
import 'package:auth_jwt/core/logger/logger.dart';
import 'package:auth_jwt/middlewares/content_type/content_type.dart';
import 'package:auth_jwt/routes/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

typedef Handler = FutureOr<Response> Function(Request);

Future<void> main(List<String> arguments) async {
  final Env env = Env.instance;
  final Logger log = Logger.instance;

  final int port = int.parse(env['serverPort']!);
  final String host = env['serverHost']!;

  final Routes routes = Routes();
  final Handler pipeline = Pipeline().addMiddleware(logRequests()).addMiddleware(ContentType().handler).addHandler(routes.router.call);

  final HttpServer server = await shelf_io.serve(pipeline, host, port);

  log.info(message: 'Serving at -> Port: $port | Host: $host | http://localhost:8080/');
}

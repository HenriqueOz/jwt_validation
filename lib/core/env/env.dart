import 'dart:io';
import 'package:auth_jwt/core/logger/logger.dart';

class Env {
  static Logger log = Logger.instance;

  Env._() {
    _loadEnvironment();
  }

  static final Env _instance = Env._();
  static Env get instance => _instance;

  static final Map<String, String> _env = {};

  static String? getValue({required String key}) => _env[key];
  String? operator [](String key) => _env[key];

  void _loadEnvironment() {
    try {
      List<String> lines = File('.env').readAsLinesSync();
      _env.addAll(_linesToMap(lines: lines));
      log.info(message: 'Environment loaded');
    } on PathNotFoundException catch (e) {
      Logger.instance.error(message: '.env file not found', error: e);
    } on Exception catch (e, s) {
      Logger.instance.error(message: '.env file not found', error: e, stackTrace: s);
    }
  }

  Map<String, String> _linesToMap({required List<String> lines}) {
    final Map<String, String> map = {};

    for (final String line in lines) {
      final List<String> split = line.split('=');
      map.addAll({
        split[0]: split[1],
      });
    }

    return map;
  }
}

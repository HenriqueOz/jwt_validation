import 'package:auth_jwt/core/logger/i_logger.dart';

class Logger implements ILogger {
  Logger._();

  static final Logger _logger = Logger._();
  static Logger get instance => _logger;

  void _log({required String flag, required String message, required StackTrace? stackTrace, required Exception? error}) {
    print('[$flag] $message');

    if (error != null) {
      print('[$flag] $error');
    }

    if (stackTrace != null) {
      print('[$flag] $stackTrace');
    }
  }

  @override
  void error({required String message, StackTrace? stackTrace, Exception? error}) {
    _log(flag: 'ERROR', message: message, stackTrace: stackTrace, error: error);
  }

  @override
  void info({required String message, StackTrace? stackTrace, Exception? error}) {
    _log(flag: 'INFO', message: message, stackTrace: stackTrace, error: error);
  }

  @override
  void warning({required String message, StackTrace? stackTrace, Exception? error}) {
    _log(flag: 'WARNING', message: message, stackTrace: stackTrace, error: error);
  }
}

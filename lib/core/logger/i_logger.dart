abstract interface class ILogger {
  void error({required String message, StackTrace? stackTrace, Exception? error});

  void info({required String message, StackTrace? stackTrace, Exception? error});

  void warning({required String message, StackTrace? stackTrace, Exception? error});
}

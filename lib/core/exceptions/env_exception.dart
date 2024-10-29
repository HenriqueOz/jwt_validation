enum EnvExceptionType {
  fileNotFound,
}

class EnvException {
  final String message;

  EnvException._({required this.message});

  factory EnvException({required final EnvExceptionType type}) {
    switch (type) {
      case EnvExceptionType.fileNotFound:
        return EnvException._(message: 'File Not Found');
    }
  }
}

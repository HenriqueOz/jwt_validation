enum EnvEnum {
  fileNotFound,
}

class EnvException {
  final String message;

  EnvException._({required this.message});

  factory EnvException({required final EnvEnum type}) {
    switch (type) {
      case EnvEnum.fileNotFound:
        return EnvException._(message: 'File Not Found');
    }
  }
}

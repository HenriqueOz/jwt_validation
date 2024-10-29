import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class CryptHelper {
  static String generateSha256String({required String source}) {
    final Uint8List bytes = utf8.encode(source);
    return sha256.convert(bytes).toString();
  }
}

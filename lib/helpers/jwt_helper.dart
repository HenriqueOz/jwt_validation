import 'package:auth_jwt/core/env/env.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

final Env env = Env.instance;

class JwtHelper {
  static final String _jwtSecret = env['jwtSecret']!;

  static String generateJwtToken({required int userId, required String email}) {
    // final JWT jwt = JWT(
    //   // Payload
    //   {
    //     'iss': 'https://test.com',
    //     'sub': userId,
    //     'aud': 'someone',
    //     'exp': expiration.millisecondsSinceEpoch ~/ 1000,
    //     'nbt': now.millisecondsSinceEpoch ~/ 1000,
    //     'iat': now.millisecondsSinceEpoch ~/ 1000,
    //     'jti': '',
    //   },
    // );

    final JWT jwt = JWT(
      {
        'email': email,
      },
      subject: userId.toString(),
      audience: Audience(['somenone']),
      issuer: 'maybe_i',
    );

    final String accessToken = jwt.sign(
      SecretKey(_jwtSecret),
      notBefore: Duration(days: 0),
      expiresIn: Duration(days: 1),
    );

    return 'Bearer $accessToken';
  }
}

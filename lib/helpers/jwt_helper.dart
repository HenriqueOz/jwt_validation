import 'package:auth_jwt/core/env/env.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

final Env env = Env.instance;

class JwtHelper {
  static final String _jwtSecret = env['jwtSecret']!;

  static String generateJwtAccessToken({required int userId, required String email}) {
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
      expiresIn: Duration(seconds: 10),
    );

    return 'Bearer $accessToken';
  }

  static String generateJwtRefreshToken({required String accessToken}) {
    final JWT jwt = JWT(
      {},
      subject: accessToken,
      audience: Audience(['somenone']),
      issuer: 'maybe_i',
    );

    final String refreshToken = jwt.sign(
      SecretKey(_jwtSecret),
      notBefore: Duration(days: 0),
      expiresIn: Duration(days: 15),
    );

    return 'Bearer $refreshToken';
  }

  static JWT verifyToken({required String token}) {
    return JWT.verify(token, SecretKey(_jwtSecret));
  }
}

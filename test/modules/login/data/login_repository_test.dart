import 'package:auth_jwt/entities/user_entity.dart';
import 'package:auth_jwt/helpers/crypt_helper.dart';
import 'package:auth_jwt/modules/login/data/login_repository.dart';
import 'package:test/test.dart';

void main() {
  late LoginRepository loginRepository;

  setUp(() {
    loginRepository = LoginRepository.instance;
  });

  group(
    'Login method',
    () {
      test(
        'Should login successfully',
        () async {
          final UserEntity expectedUser = UserEntity(
            id: 5,
            email: 'test@email.com',
            password: CryptHelper.generateSha256String(source: 'password'),
          );

          final UserEntity? user = loginRepository.login(email: 'test@email.com', password: 'password');

          expect(user, expectedUser);
        },
      );

      test(
        'Should return null with wrong password',
        () async {
          final UserEntity? user = loginRepository.login(email: 'test@email.com', password: '');

          expect(user, isNull);
        },
      );

      test(
        'Should return null with wrong email',
        () async {
          final UserEntity? user = loginRepository.login(email: '', password: '');

          expect(user, isNull);
        },
      );
    },
  );
}

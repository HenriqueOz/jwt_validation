import 'package:auth_jwt/entities/user_entity.dart';
import 'package:auth_jwt/helpers/crypt_helper.dart';
import 'package:test/test.dart';
import 'package:auth_jwt/core/database/database.dart';

void main() {
  late Database database;

  setUp(() {
    database = Database.instance;
  });

  group(
    'Get user method',
    () {
      test(
        'Should return a user entity by id from the json',
        () {
          final int id = 1;
          final UserEntity expectUser = UserEntity(
            id: id,
            email: 'test@email.com',
            password: CryptHelper.generateSha256String(source: 'password'),
          );

          final UserEntity? user = database.getUser(id: id);

          expect(user, expectUser);
        },
      );

      test(
        'Should return null when you request a id that does not exists',
        () {
          final int id = -1;

          final UserEntity? user = database.getUser(id: id);

          expect(user, isNull);
        },
      );
    },
  );

  group(
    'Insert user method',
    () {
      test(
        'Should insert a user inside the json',
        () {
          final int pastId = database.lastId;
          final String email = 'test@email.com';
          final String password = 'password';

          database.insertUser(email: email, password: password);

          expect(database.lastId, pastId + 1);
        },
      );
    },
  );
}

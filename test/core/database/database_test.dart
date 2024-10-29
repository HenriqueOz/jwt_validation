import 'package:auth_jwt/entities/user_entity.dart';
import 'package:test/test.dart';
import 'package:auth_jwt/core/database/database.dart';

void main() {
  late Database database;

  setUp(() {
    database = Database();
  });

  group(
    'Get user method',
    () {
      test('Should return a user entity by id from the json', () {
        final int id = 0;
        final UserEntity expectUser = UserEntity(
          id: 0,
          email: 'random@email.com',
          password: 'randompassword',
        );

        final UserEntity? user = database.getUser(id: id);

        expect(user, expectUser);
      });

      test('Should return null when you request a id that does not exists', () {
        final int id = -1;

        final UserEntity? user = database.getUser(id: id);

        expect(user, isNull);
      });
    },
  );
}

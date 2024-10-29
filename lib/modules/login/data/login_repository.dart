import 'package:auth_jwt/core/database/database.dart';
import 'package:auth_jwt/entities/user_entity.dart';
import 'package:auth_jwt/helpers/crypt_helper.dart';

class LoginRepository {
  LoginRepository._();

  static final LoginRepository _instance = LoginRepository._();
  static LoginRepository get instance => _instance;

  final Database database = Database.instance;

  UserEntity? login({required String email, required String password}) {
    try {
      final Map<String, dynamic> data = database.getJsonData();

      for (MapEntry<String, dynamic> entry in data.entries) {
        final String entryEmail = entry.value['email'];

        if (entryEmail == email) {
          final String hashPassword = CryptHelper.generateSha256String(source: password);
          final String entryPassword = entry.value['password'];

          if (hashPassword == entryPassword) {
            return UserEntity(id: int.parse(entry.key), email: email, password: hashPassword);
          }
        }
      }
      return null;
    } on Exception {
      throw Exception();
    }
  }

  void registerUser({required String email, required String password}) {
    try {
      database.insertUser(email: email, password: password);
    } on Exception {
      throw Exception();
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:auth_jwt/entities/user_entity.dart';

class Database {
  Map<String, dynamic> getJsonData() {
    return jsonDecode(File('database/users.json').readAsStringSync());
  }

  UserEntity? getUser({required int id}) {
    final Map<String, dynamic> jsonData = getJsonData();
    final Map<String, dynamic>? userData = jsonData[id.toString()];

    if (userData == null) {
      return null;
    }

    return UserEntity(id: id, email: userData['email'], password: userData['password']);
  }

  void insertUser() {}

  void updateUser() {}

  void deleteUser() {}
}

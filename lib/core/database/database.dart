import 'dart:convert';
import 'dart:io';

import 'package:auth_jwt/core/logger/logger.dart';
import 'package:auth_jwt/entities/user_entity.dart';
import 'package:auth_jwt/helpers/crypt_helper.dart';

class Database {
  static int lastId = 0;

  Database._() {
    final Map<String, dynamic> data = getJsonData();

    if (data.isEmpty) {
      lastId = 0;
      return;
    }

    lastId = int.tryParse(data.keys.last) ?? 0;
    print(lastId);
  }

  static final Database _instance = Database._();
  static Database get instance => _instance;

  final String jsonPath = 'database/users.json';
  final Logger log = Logger.instance;

  void writeJson({required Map<String, dynamic> data}) {
    try {
      File(jsonPath).writeAsStringSync(jsonEncode(data));
    } on Exception catch (e, s) {
      log.error(message: 'Error while writing json', error: e, stackTrace: s);
    }
  }

  Map<String, dynamic> getJsonData() {
    try {
      return jsonDecode(File(jsonPath).readAsStringSync());
    } on Exception catch (e, s) {
      log.error(message: 'Error while decoding json', error: e, stackTrace: s);
    }
    return {};
  }

  UserEntity? getUser({required int id}) {
    final Map<String, dynamic> jsonData = getJsonData();
    final Map<String, dynamic>? userData = jsonData[id.toString()];

    if (userData == null) {
      return null;
    }

    return UserEntity(id: id, email: userData['email'], password: userData['password']);
  }

  void insertUser({required String email, required String password}) {
    lastId++;

    final Map<String, dynamic> data = getJsonData();

    data[lastId.toString()] = {
      'email': email,
      'password': CryptHelper.generateSha256String(source: password),
    };

    writeJson(data: data);
  }
}

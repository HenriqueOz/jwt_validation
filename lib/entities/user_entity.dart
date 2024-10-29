// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final int id;
  final String email;
  final String password;

  UserEntity({
    required this.id,
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ password.hashCode;
}

class UserModel {
  final String name;
  final String email;
  final String? password;
  final String? uid;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.uid,
  });
}

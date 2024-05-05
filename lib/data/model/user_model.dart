class User {
  final String full_name;
  final String phone_number;
  final String password;

  User(
      {required this.full_name,
      required this.phone_number,
      required this.password});

  String toString() {
    return (" $full_name, $phone_number, $password");
  }
}

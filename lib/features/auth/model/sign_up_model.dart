
class SignUpModel {
  final String name;
  final String email;
  final String password;

  SignUpModel({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

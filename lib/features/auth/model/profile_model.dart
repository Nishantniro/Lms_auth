class ProfileModel {
  final String id;
  final String username;
  final String name;
  final String email;
  final List<String> roles;

  ProfileModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.roles,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      roles: List<String>.from(map['roles'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'roles': roles,
    };
  }
}

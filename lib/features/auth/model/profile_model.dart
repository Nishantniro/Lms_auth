class ProfileModel {
  final String id;
  final String username;
  final String name;
  final String email;
  final List<String> roles;
  final bool hastrainerprofile;

  ProfileModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.roles,
    required this.hastrainerprofile,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      roles: List<String>.from(map['roles'] ?? []),
      hastrainerprofile: map['has_trainer_profile'],
    );
  }
}


class TokenModel {
  final String access;
  final String refresh;

  TokenModel({
    required this.access,
    required this.refresh,
  });

  factory TokenModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return TokenModel(
      access: map['access'],
      refresh: map['refresh'],
    );
  }
}
class UserInfoEntity {
  final int id;
  final String name;
  final String photoUrl;
  final String email;

  UserInfoEntity({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfoEntity &&
        other.id == id &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ photoUrl.hashCode ^ email.hashCode;
  }
}

class LoginRequestEntity {
  final String login;
  final String password;

  LoginRequestEntity({
    required this.login,
    required this.password,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginRequestEntity &&
        other.login == login &&
        other.password == password;
  }

  @override
  int get hashCode => login.hashCode ^ password.hashCode;
}

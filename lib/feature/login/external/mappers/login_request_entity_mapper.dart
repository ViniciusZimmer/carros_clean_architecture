import '../../domain/entities/login_request_entity.dart';

class LoginRequestEntityMapper {
  static Map<String, dynamic> toMap({required LoginRequestEntity entity}) {
    return {
      'username': entity.login,
      'password': entity.password,
    };
  }
}

import '../../domain/entities/user_info_entity.dart';

class UserInfoEntityMapper {
  static UserInfoEntity fromMap({required Map<String, dynamic> map}) {
    return UserInfoEntity(
      id: map['id'],
      name: map['nome'],
      photoUrl: map['urlFoto'],
      email: map['email'],
    );
  }
}

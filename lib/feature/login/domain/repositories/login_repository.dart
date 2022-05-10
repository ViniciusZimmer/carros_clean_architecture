import '../entities/login_request_entity.dart';
import '../entities/user_info_entity.dart';

abstract class LoginRepository {
  Future<UserInfoEntity> doLogin(
      {required LoginRequestEntity loginRequestEntity});
}

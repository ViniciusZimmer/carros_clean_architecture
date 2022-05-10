import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/user_info_entity.dart';

abstract class LoginDatasource {
  Future<UserInfoEntity> doLogin(
      {required LoginRequestEntity loginRequestEntity});
}

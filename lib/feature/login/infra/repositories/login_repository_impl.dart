import '../../domain/entities/user_info_entity.dart';

import '../../domain/entities/login_request_entity.dart';
import '../../domain/failures/login_failure.dart';

import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _loginDatasource;

  LoginRepositoryImpl({required LoginDatasource loginDatasource})
      : _loginDatasource = loginDatasource;
  @override
  Future<UserInfoEntity> doLogin(
      {required LoginRequestEntity loginRequestEntity}) async {
    try {
      return await _loginDatasource.doLogin(
        loginRequestEntity: loginRequestEntity,
      );
    } on LoginFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownLoginFailure(
        stackTrace: stackTrace,
        label: 'LoginRepositoryImpl - doLogin',
      );
    }
  }
}

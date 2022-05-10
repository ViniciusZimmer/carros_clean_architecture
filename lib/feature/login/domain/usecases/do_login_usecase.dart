import '../entities/login_request_entity.dart';
import '../entities/user_info_entity.dart';
import '../failures/login_failure.dart';
import '../repositories/login_repository.dart';

abstract class DoLoginUsecase {
  Future<UserInfoEntity> call({required LoginRequestEntity loginRequestEntity});
}

class DoLoginUsecaseImpl implements DoLoginUsecase {
  final LoginRepository _repository;

  DoLoginUsecaseImpl({
    required LoginRepository loginRepository,
  }) : _repository = loginRepository;

  @override
  Future<UserInfoEntity> call({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    if (loginRequestEntity.login.isEmpty ||
        loginRequestEntity.password.isEmpty) {
      throw InvalidCredentialsLoginFailure();
    }
    return await _repository.doLogin(loginRequestEntity: loginRequestEntity);
  }
}

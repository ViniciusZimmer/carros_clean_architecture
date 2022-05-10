import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/domain/entities/user_info_entity.dart';
import 'package:clean_cars/feature/login/domain/failures/login_failure.dart';
import 'package:clean_cars/feature/login/domain/repositories/login_repository.dart';
import 'package:clean_cars/feature/login/domain/usecases/do_login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

void main() {
  late DoLoginUsecase usecase;
  late LoginRepository repository;

  setUp(() {
    repository = LoginRepositoryMock();
    usecase = DoLoginUsecaseImpl(loginRepository: repository);
    registerFallbackValue(
      LoginRequestEntity(
        login: 'user',
        password: '123',
      ),
    );
  });

  test(
      'Verifica se o usecase retorna uma UserInfoEntity retornada pelo repository',
      () async {
    //Arrange
    final LoginRequestEntity request = LoginRequestEntity(
      login: 'wendell@gmail.com',
      password: 'passoncn',
    );

    final UserInfoEntity response = UserInfoEntity(
      id: 42,
      name: 'wendell',
      photoUrl: 'dbkfdb',
      email: 'whatebr@com',
    );

    when(
      () => repository.doLogin(
        loginRequestEntity: any(named: 'loginRequestEntity'),
      ),
    ).thenAnswer((_) async => response);

    //Act
    final result = await usecase.call(loginRequestEntity: request);

    //Assert
    expect(result, response);
    verify(() => repository.doLogin(loginRequestEntity: request)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'Dar throw em uma InvalidCredentialsLoginFailure, quando o atributo login for vazio',
      () {
    //Arrange
    final LoginRequestEntity request = LoginRequestEntity(
      login: '',
      password: 'passoncn',
    );

    //Assert
    expect(() => usecase.call(loginRequestEntity: request),
        throwsA(isA<InvalidCredentialsLoginFailure>()));

    verifyNever(() => repository.doLogin(loginRequestEntity: request));
  });

  test(
      'Dar throw em uma InvalidCredentialsLoginFailure, quando o atributo password for vazio',
      () {
    //Arrange
    final LoginRequestEntity request = LoginRequestEntity(
      login: 'efsfsf.com',
      password: '',
    );

    //Assert
    expect(
      () => usecase.call(loginRequestEntity: request),
      throwsA(
        InvalidCredentialsLoginFailure(),
      ),
    );

    verifyNever(() => repository.doLogin(loginRequestEntity: request));
  });
}

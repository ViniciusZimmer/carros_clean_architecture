import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/domain/entities/user_info_entity.dart';
import 'package:clean_cars/feature/login/domain/failures/login_failure.dart';
import 'package:clean_cars/feature/login/domain/repositories/login_repository.dart';
import 'package:clean_cars/feature/login/infra/datasources/login_datasource.dart';
import 'package:clean_cars/feature/login/infra/repositories/login_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginDatasourceMock extends Mock implements LoginDatasource {}

void main() {
  late LoginDatasource datasource;
  late LoginRepository repository;

  setUp(() {
    datasource = LoginDatasourceMock();
    repository = LoginRepositoryImpl(loginDatasource: datasource);
    registerFallbackValue(
      LoginRequestEntity(
        login: 'user',
        password: '123',
      ),
    );
  });

  test(
      'Deve retornar um UserInfoEntity, quando o dataSource for executado com sucesso.',
      () async {
    // arrange
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
      () => datasource.doLogin(
        loginRequestEntity: any(named: 'loginRequestEntity'),
      ),
    ).thenAnswer((_) async => response);

    // act
    final result = await repository.doLogin(loginRequestEntity: request);

    // assert
    expect(result, response);
    verify(() => datasource.doLogin(loginRequestEntity: request)).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test('Deve lançar um rethrow, quando o dataSource lançar uma LoginFailure.',
      () {
    // arrange
    final LoginRequestEntity request = LoginRequestEntity(
      login: 'wendell@gmail.com',
      password: 'passoncn',
    );
    when(
      () => datasource.doLogin(
        loginRequestEntity: any(named: 'loginRequestEntity'),
      ),
    ).thenThrow(NoInternetLoginFailure());

    // assert
    expect(
      () => repository.doLogin(loginRequestEntity: request),
      throwsA(
        NoInternetLoginFailure(),
      ),
    );

    verify(() => datasource.doLogin(loginRequestEntity: request)).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test(
      'Deve lançar uma UnknownLoginFailure, quando o dataSource lançar qualquer exceçao.',
      () {
    // arrange
    final LoginRequestEntity request = LoginRequestEntity(
      login: 'wendell@gmail.com',
      password: 'passoncn',
    );
    when(
      () => datasource.doLogin(
        loginRequestEntity: any(named: 'loginRequestEntity'),
      ),
    ).thenThrow(Exception());

    // assert
    expect(
      () => repository.doLogin(loginRequestEntity: request),
      throwsA(
        UnknownLoginFailure(),
      ),
    );

    verify(() => datasource.doLogin(loginRequestEntity: request)).called(1);
    verifyNoMoreInteractions(datasource);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/domain/entities/user_info_entity.dart';
import 'package:clean_cars/feature/login/domain/failures/login_failure.dart';
import 'package:clean_cars/feature/login/domain/usecases/do_login_usecase.dart';
import 'package:clean_cars/feature/login/presenter/cubits/login_cubit.dart';
import 'package:clean_cars/feature/login/presenter/cubits/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginUseCaseMock extends Mock implements DoLoginUsecaseImpl {}

void main() {
  late LoginUseCaseMock loginUsecase;
  late LoginCubit loginCubit;

  setUp(() {
    loginUsecase = LoginUseCaseMock();
    loginCubit = LoginCubit(usecase: loginUsecase);
  });

  tearDown(() {
    loginCubit.close();
  });

  test(
    'Verificar se o estado inicial é um LoginInitialState',
    () {
      final initialState = loginCubit.state;

      expect(
        initialState,
        isA<LoginInitialState>(),
      );
    },
  );

  //arrange

  final LoginRequestEntity request = LoginRequestEntity(
    login: 'usuario',
    password: 'password',
  );

  final UserInfoEntity response = UserInfoEntity(
    id: 42,
    name: 'wendell',
    photoUrl: 'dbkfdb',
    email: 'whatebr@com',
  );

  group('doLogin Teste sem pacote', () {
    test(
      'Emite o [LoginLoadingState,LoginSucessState] ao invocar o usecase.call com o LoginRequestEntity válido e o usecase retorna um UserInfoEntity válido',
      () async {
        when(
          () => loginUsecase.call(
            loginRequestEntity: request,
          ),
        ).thenAnswer((_) async => response);

        //assert

        expectLater(
          loginCubit.stream,
          emitsInOrder(
            [
              isA<LoginLoadingState>(),
              LoginSuccessState(user: response),
            ],
          ),
        );

        //act

        await loginCubit.doLogin(request);
      },
    );

    test(
      'Emite o [LoginLoadingState,LoginErrorState] ao invocar o usecase.call com o LoginRequestEntity válido e o usecase da throw em qualquer classe derivada de LoginFailure',
      () async {
        when(
          () => loginUsecase.call(
            loginRequestEntity: request,
          ),
        ).thenThrow(UnknownLoginFailure());

        //assert

        expectLater(
          loginCubit.stream,
          emitsInOrder(
            [
              isA<LoginLoadingState>(),
              // ignore: prefer_const_constructors
              LoginErrorState(
                  errorMessage: 'Ocorreu um erro inesperado, tente novamente.'),
            ],
          ),
        );

        //act

        await loginCubit.doLogin(request);
      },
    );
  });

  group('doLogin Teste com pacotes', () {
    blocTest<LoginCubit, LoginState>(
      'Emite o [LoginLoadingState,LoginSucessState] ao invocar o usecase.call com o LoginRequestEntity válido e o usecase retorna um UserInfoEntity válido',
      build: () {
        when(
          () => loginUsecase.call(
            loginRequestEntity: request,
          ),
        ).thenAnswer((_) async => response);

        return LoginCubit(usecase: loginUsecase);
      },
      act: (cubit) => cubit.doLogin(request),
      expect: () => [
        isA<LoginLoadingState>(),
        LoginSuccessState(user: response),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Emite o [LoginLoadingState,LoginErrorState] ao invocar o usecase.call com o LoginRequestEntity válido e o usecase da throw em qualquer classe derivada de LoginFailure',
      build: () {
        when(
          () => loginUsecase.call(
            loginRequestEntity: request,
          ),
        ).thenThrow(UnknownLoginFailure());

        return LoginCubit(usecase: loginUsecase);
      },
      act: (cubit) => cubit.doLogin(request),
      expect: () => [
        isA<LoginLoadingState>(),
        // ignore: prefer_const_constructors
        LoginErrorState(
            errorMessage: 'Ocorreu um erro inesperado, tente novamente.'),
      ],
    );
  });
}

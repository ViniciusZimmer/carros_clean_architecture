import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/domain/entities/user_info_entity.dart';
import 'package:clean_cars/feature/login/domain/failures/login_failure.dart';
import 'package:clean_cars/feature/login/domain/usecases/do_login_usecase.dart';
import 'package:clean_cars/feature/login/presenter/cubits/login_cubit.dart';
import 'package:clean_cars/feature/login/presenter/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DoLoginUsecaseMock extends Mock implements DoLoginUsecase {}

void main() {
  late DoLoginUsecaseMock usecase;

  setUp(() {
    usecase = DoLoginUsecaseMock();
    registerFallbackValue(
      LoginRequestEntity(
        login: 'user',
        password: '123',
      ),
    );
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => LoginCubit(usecase: usecase),
        child: const LoginPage(),
      ),
    );
  }

  testWidgets(
      'Verifica se ao iniciar a tela a mesma contém a imagem de fundo, os textFields de login e senha, e o botão de login',
      (tester) async {
    // Renderiza a tela
    await tester.pumpWidget(
      createTestWidget(),
    );

    // Encontrar os Widgets pela chave
    final imageLogo = find.byKey(const Key('nf-logo-image'));
    final textFieldLogin = find.byKey(const Key('textfield-login'));
    final textFieldPassword = find.byKey(const Key('textfield-password'));
    final buttonLogin = find.byKey(const Key('button-login'));

    // Verificar se os Widgets aparece por uma vez
    expect(imageLogo, findsOneWidget);
    expect(textFieldLogin, findsOneWidget);
    expect(textFieldPassword, findsOneWidget);
    expect(buttonLogin, findsOneWidget);
  });

  // testWidgets('''
  //       Ao digitar login e senha em seus respectivos campos de texto:
  //       1) Apertar o botão
  //       2) Visualizar o indicador de loading

  //       Quando o usecase me retornar um UserInfoEntity
  //     ''', (tester) async {
  //   //Arrange
  //   final LoginRequestEntity request = LoginRequestEntity(
  //     login: 'user',
  //     password: '123',
  //   );

  //   final UserInfoEntity response = UserInfoEntity(
  //     id: 42,
  //     name: 'wendell',
  //     photoUrl: 'dbkfdb',
  //     email: 'whatebr@com',
  //   );

  //   when(
  //     () => usecase.call(
  //       loginRequestEntity: any(named: 'loginRequestEntity'),
  //     ),
  //   ).thenAnswer(
  //     (_) async {
  //       await Future.delayed(const Duration(seconds: 1));
  //       return response;
  //     },
  //   );

  //   await tester.pumpWidget(
  //     createTestWidget(),
  //   );

  //   // Digitar no campo login
  //   // Achar o textField
  //   final textFieldLogin = find.byKey(const Key('textfield-login'));

  //   // Colocar o texto de login
  //   await tester.enterText(textFieldLogin, request.login);

  //   // Digitar no campo password
  //   // Achar o textField
  //   final textFieldPassword = find.byKey(const Key('textfield-password'));

  //   // Colocar o texto de senha
  //   await tester.enterText(textFieldPassword, request.password);

  //   // Clicar no button Login
  //   // Achar o button Login
  //   final buttonLogin = find.byKey(const Key('button-login'));

  //   // Clicar no button Login
  //   await tester.tap(buttonLogin);

  //   // Atualizar UI
  //   await tester.pump();

  //   // Verificar se exite um CircularProgressIndicator
  //   final circularProgressIndicator = find.byType(CircularProgressIndicator);

  //   expect(circularProgressIndicator, findsOneWidget);

  //   //Espero o termino da animação do CircularProgressIndicator
  //   await tester.pumpAndSettle();

  //   //Verificar se o Alert de Sucesso aparece na tela
  //   final successAlert = find.byType(AlertDialog);

  //   expect(successAlert, findsOneWidget);

  //   verify(() => usecase.call(loginRequestEntity: request)).called(1);
  //   verifyNoMoreInteractions(usecase);
  // });

  testWidgets(
    '''
        Ao digitar login e senha em seus respectivos campos de texto:
        1) Apertar o botão

        Quando o usecase me lançar qualquer classe derivada de LoginFailure
      ''',
    (tester) async {
      //Arrange
      final LoginRequestEntity request = LoginRequestEntity(
        login: 'user',
        password: '123',
      );

      when(
        () => usecase.call(
          loginRequestEntity: any(named: 'loginRequestEntity'),
        ),
      ).thenThrow(UnknownLoginFailure());

      await tester.pumpWidget(
        createTestWidget(),
      );

      // Digitar no campo login
      // Achar o textField
      final textFieldLogin = find.byKey(const Key('textfield-login'));

      // Colocar o texto de login
      await tester.enterText(textFieldLogin, request.login);

      // Digitar no campo password
      // Achar o textField
      final textFieldPassword = find.byKey(const Key('textfield-password'));

      // Colocar o texto de senha
      await tester.enterText(textFieldPassword, request.password);

      // Clicar no button Login
      // Achar o button Login
      final buttonLogin = find.byKey(const Key('button-login'));

      // Clicar no button Login
      await tester.tap(buttonLogin);

      verify(() => usecase.call(loginRequestEntity: request)).called(1);
      verifyNoMoreInteractions(usecase);
    },
  );
}

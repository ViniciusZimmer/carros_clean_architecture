import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/domain/entities/user_info_entity.dart';
import 'package:clean_cars/feature/login/domain/failures/login_failure.dart';
import 'package:clean_cars/feature/login/external/datasources/login_datasource_impl.dart';
import 'package:clean_cars/feature/login/infra/datasources/login_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  late LoginDatasource loginDatasource;

  setUp(() {
    dio = DioMock();
    loginDatasource = LoginDatasourceImpl(dio: dio);
    registerFallbackValue(
      LoginRequestEntity(
        login: 'user',
        password: '123',
      ),
    );
  });

  group('doLogin', () {
    //arrange
    final mapRequest = {'username': 'teste', 'password': 'teste'};
    final LoginRequestEntity loginRequestEntity =
        LoginRequestEntity(login: 'teste', password: 'teste');

    test(
        'Retorna um UserInfoEntity caso o dio retorne Response com status code 200 e o data sendo um Map',
        () async {
      final mapResponse = {
        'id': 3,
        'login': 'user',
        'nome': 'User',
        'email': 'user@gmail.com',
        'urlFoto':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqP85ZnOcRSCX3nlYdkCvSxhSuZs0bLt1He8EvGr5ne8c7mTqW',
        'token':
            'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyIiwiZXhwIjoxNjUwMjAyNjMwLCJyb2wiOlsiUk9MRV9VU0VSIl19.Tlt56L_DlNlqWbtBCAVT1HU4sRncuH3WFgICJjwHufTTvuICJBFXjnnP3-9_pHlQ_2m1QqWdbQXjc9TBHtY8mw',
        'roles': ['ROLE_USER']
      };

      when(
        () => dio.post(any(), data: mapRequest),
      ).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: mapResponse,
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v2/login',
          ),
        ),
      );

      //Act
      final result =
          await loginDatasource.doLogin(loginRequestEntity: loginRequestEntity);

      //Assert
      expect(
        result,
        UserInfoEntity(
            id: 3,
            name: 'User',
            photoUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqP85ZnOcRSCX3nlYdkCvSxhSuZs0bLt1He8EvGr5ne8c7mTqW',
            email: 'user@gmail.com'),
      );

      verify(
        (() => dio.post(
              'https://carros-springboot.herokuapp.com/api/v2/login',
              data: mapRequest,
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });

    test(
        'Lancar um excessão do tipo DataSourceLoginFailure caso status code do Response seja diferente de 200 ',
        () {
      //Arrange

      final mapResponse = {'error': 'Login incorreto'};

      when(
        () => dio.post(any(), data: mapRequest),
      ).thenAnswer(
        (_) async => Response(
          statusCode: 205,
          data: mapResponse,
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v2/login',
          ),
        ),
      );

      //Assert
      expect(
        () => loginDatasource.doLogin(loginRequestEntity: loginRequestEntity),
        throwsA(DataSourceLoginFailure(errorMessage: 'Login incorreto')),
      );

      verify(
        (() => dio.post(
              'https://carros-springboot.herokuapp.com/api/v2/login',
              data: mapRequest,
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });

    test(
        'Lancar um excessão do tipo NoInternetLoginFailure quando o dio der throw em um DioError e o tipo do dioErrorType indicar um time out  ',
        () {
      //Arrange

      when(
        () => dio.post(any(), data: mapRequest),
      ).thenThrow(DioError(
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v2/login',
          ),
          type: DioErrorType.connectTimeout));

      //Assert
      expect(
        () => loginDatasource.doLogin(loginRequestEntity: loginRequestEntity),
        throwsA(NoInternetLoginFailure()),
      );

      verify(
        (() => dio.post(
              'https://carros-springboot.herokuapp.com/api/v2/login',
              data: mapRequest,
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });

    test(
        'Lancar um excessão do tipo UnknownLoginFailure quando o dio der throw em um DioError e o dioErrorType for diferente de um dos tipos time out ',
        () {
      //Arrange

      when(
        () => dio.post(any(), data: mapRequest),
      ).thenThrow(DioError(
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v2/login',
          ),
          type: DioErrorType.other));

      //Assert
      expect(
        () => loginDatasource.doLogin(loginRequestEntity: loginRequestEntity),
        throwsA(UnknownLoginFailure()),
      );

      verify(
        (() => dio.post(
              'https://carros-springboot.herokuapp.com/api/v2/login',
              data: mapRequest,
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });
  });
}

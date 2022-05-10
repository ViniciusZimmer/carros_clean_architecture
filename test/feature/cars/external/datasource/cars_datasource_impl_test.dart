import 'package:clean_cars/feature/cars/domain/entities/cars_entity.dart';
import 'package:clean_cars/feature/cars/domain/failures/failures.dart';
import 'package:clean_cars/feature/cars/external/datasource/cars_datasource_impl.dart';
import 'package:clean_cars/feature/cars/infra/datasources/cars_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  late CarsDatasource carsDatasource;

  setUp(() {
    dio = DioMock();
    carsDatasource = CarsDatasourceImpl(dio: dio);
  });

  group('getCars', () {
    test(
        'Retorna List<CarsEntity> caso o dio retorne Response com status code 200 e o data sendo List',
        () async {
      final mapResponse = {
        'results': [
          {
            "id": 13301,
            "nome": "Ford Mustang 1976 BBB",
            "tipo": "classicos",
            "descricao": "Desc Ford Mustang 1976fwsafdfasd",
            "urlFoto":
                "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Ford_Mustang.png",
            "urlVideo":
                "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/ford_mustang.mp4",
            "latitude": "-23.564224",
            "longitude": "-46.653156"
          }
        ]
      };

      when(
        () => dio.get(
          any(),
        ),
      ).thenAnswer((_) async => Response(
            statusCode: 200,
            data: mapResponse,
            requestOptions: RequestOptions(
              path: 'https://carros-springboot.herokuapp.com/api/v1/carros',
            ),
          ));

      //Act
      final result = await carsDatasource.getCars();

      //Assert
      expect(result, isA<List<CarsEntity>>());

      verify(
        (() => dio.get(
              'https://carros-springboot.herokuapp.com/api/v1/carros',
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });

    test(
        'Lança DatasourceCarsFailure caso o dio retorne Response com status code diferente de 200',
        () async {
      final mapResponse = {
        'status_message': 'Backend error',
      };

      when(
        () => dio.get(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          data: mapResponse,
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v1/carros',
          ),
        ),
      );

      //Assert
      expect(
        () => carsDatasource.getCars(),
        throwsA(
          DataSourceCarsFailure(errorMessage: 'Backend error'),
        ),
      );

      verify(
        (() => dio.get(
              'https://carros-springboot.herokuapp.com/api/v1/carros',
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });

    test(
        'Lança NoInternetCarsFailure caso o dio lançe um DioError com um DioErrorType indicando timeout',
        () async {
      when(
        () => dio.get(
          any(),
        ),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v1/carros',
          ),
          type: DioErrorType.connectTimeout,
        ),
      );

      //Assert
      expect(
        () => carsDatasource.getCars(),
        throwsA(NoInternetCarsFailure()),
      );

      verify(
        (() => dio.get(
              'https://carros-springboot.herokuapp.com/api/v1/carros',
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });

    test(
        'Lança NoInternetMovieFailure caso o dio lançe um DioError com um DioErrorType generico',
        () async {
      when(
        () => dio.get(
          any(),
        ),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: 'https://carros-springboot.herokuapp.com/api/v1/carros',
          ),
          type: DioErrorType.other,
        ),
      );

      //Assert
      expect(
        () => carsDatasource.getCars(),
        throwsA(UnknownCarsFailure()),
      );

      verify(
        (() => dio.get(
              'https://carros-springboot.herokuapp.com/api/v1/carros',
            )),
      ).called(1);

      verifyNoMoreInteractions(dio);
    });
  });
}

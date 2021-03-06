import 'package:clean_cars/feature/cars/domain/entities/cars_entity.dart';
import 'package:clean_cars/feature/cars/domain/failures/failures.dart';
import 'package:clean_cars/feature/cars/domain/repositories/cars_repository.dart';
import 'package:clean_cars/feature/cars/infra/datasources/cars_datasource.dart';
import 'package:clean_cars/feature/cars/infra/repositories/cars_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CarsDatasourceMock extends Mock implements CarsDatasource {}

void main() {
  late CarsDatasourceMock carsDatasourceMock;

  late CarsRepository carsRepository;

  setUp(() {
    carsDatasourceMock = CarsDatasourceMock();
    carsRepository = CarsRepositoryImpl(
      carsDatasource: carsDatasourceMock,
    );
  });

  test(
      'Deve retornar List<CarsEntity> quando a chamada para o datasource for sucedida',
      () async {
    //Arrange
    final response = <CarsEntity>[
      CarsEntity(
        id: 13301,
        nome: "Ford Mustang 1976 BBB",
        tipo: "classicos",
        descricao: "Desc Ford Mustang 1976fwsafdfasd",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Ford_Mustang.png",
        urlVideo:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/ford_mustang.mp4",
        latitude: "-23.564224",
        longitude: "-46.653156",
      ),
    ];

    when(() => carsDatasourceMock.getCars()).thenAnswer(
      (_) async => response,
    );

    //Act
    final result = await carsRepository.getCars();

    //Assert
    expect(result, response);
  });

  test(
      'Deve dar rethrow na falha lançada pelo datasource quando o mesmo lançar um subtipo de CarsFailure',
      () async {
    //Arrange
    when(() => carsDatasourceMock.getCars()).thenThrow(
      NoInternetCarsFailure(),
    );

    //Assert
    expect(
      () => carsRepository.getCars(),
      throwsA(
        NoInternetCarsFailure(),
      ),
    );
  });

  test(
      'Deve dar throw em UnknownCarsFailure quando o datasource lançar uma exceção que não seja um subtipo de CarsFailure',
      () async {
    //Arrange
    when(() => carsDatasourceMock.getCars()).thenThrow(
      Exception(),
    );

    //Assert
    expect(
      () => carsRepository.getCars(),
      throwsA(
        UnknownCarsFailure(),
      ),
    );
  });
}

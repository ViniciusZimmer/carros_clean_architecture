import 'package:clean_cars/feature/cars/domain/entities/cars_entity.dart';
import 'package:clean_cars/feature/cars/domain/repositories/cars_repository.dart';
import 'package:clean_cars/feature/cars/domain/usecases/get_cars_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CarsRepositoryMock extends Mock implements CarsRepository {}

void main() {
  late CarsRepositoryMock carsRepositoryMock;

  late GetCarsUsecase getCarsUsecase;

  setUp(() {
    carsRepositoryMock = CarsRepositoryMock();
    getCarsUsecase = GetCarsUsecaseImpl(carsRepository: carsRepositoryMock);
  });

  test(
      'Deve retornar List<CarsEntity> quando a chamada para o repositório for sucedida',
      () async {
    //Arrange
    final response = <CarsEntity>[
      CarsEntity(
          id: 1,
          name: 'Fiat',
          description: 'teste',
          type: 'teste',
          photoUrl: 'teste'),
    ];

    when(() => carsRepositoryMock.getCars()).thenAnswer(
      (_) async => response,
    );

    //Act
    final result = await getCarsUsecase.call();

    //Assert
    expect(result, response);
  });
}

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

    when(() => carsRepositoryMock.getCars()).thenAnswer(
      (_) async => response,
    );

    //Act
    final result = await getCarsUsecase.call();

    //Assert
    expect(result, response);
  });
}

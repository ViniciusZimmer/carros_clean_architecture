import 'package:bloc_test/bloc_test.dart';
import 'package:clean_cars/feature/cars/domain/entities/cars_entity.dart';
import 'package:clean_cars/feature/cars/domain/failures/failures.dart';
import 'package:clean_cars/feature/cars/domain/usecases/get_cars_usecase.dart';
import 'package:clean_cars/feature/cars/presenter/cubits/cars_cubit.dart';
import 'package:clean_cars/feature/cars/presenter/cubits/cars_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetCarsUsecaseMock extends Mock implements GetCarsUsecase {}

void main() {
  late GetCarsUsecaseMock getCarsUsecaseMock;

  setUp(() {
    getCarsUsecaseMock = GetCarsUsecaseMock();
  });

  group('getCars', () {
    final cars = <CarsEntity>[
      CarsEntity(
        id: 1,
        description: 'test',
        photoUrl: 'https://image.tmdb.org/t/p/w300/teste',
        type: 'teste',
        name: 'fiat',
      ),
    ];

    final unknownCarsFailure = UnknownCarsFailure();

    blocTest<CarsCubit, CarsState>(
        '''Deve emitir [CarsLoadingState, CarsLoadedState]
          quando a chamada para o usecase for sucedida.
        ''',
        setUp: () {
          when(() => getCarsUsecaseMock.call()).thenAnswer((_) async => cars);
        },
        build: () {
          return CarsCubit(getCarsUsecase: getCarsUsecaseMock);
        },
        act: (cubit) async => await cubit.getCars(),
        expect: () {
          return [
            isA<CarsLoadingState>(),
            CarsLoadedState(cars: cars),
          ];
        },
        verify: (_) {
          verify(() => getCarsUsecaseMock.call()).called(1);
          verifyNoMoreInteractions(getCarsUsecaseMock);
        });

    blocTest<CarsCubit, CarsState>(
        '''Deve emitir [CarsLoadingState, CarsErrorState]
          quando a chamada para o usecase lançar um exceção de um
          subtipo de CarsFailure.
        ''',
        setUp: () {
          when(() => getCarsUsecaseMock.call()).thenThrow(unknownCarsFailure);
        },
        build: () {
          return CarsCubit(getCarsUsecase: getCarsUsecaseMock);
        },
        act: (cubit) async => await cubit.getCars(),
        expect: () {
          return [
            isA<CarsLoadingState>(),
            CarsErrorState(errorMessage: unknownCarsFailure.errorMessage),
          ];
        },
        verify: (_) {
          verify(() => getCarsUsecaseMock.call()).called(1);
          verifyNoMoreInteractions(getCarsUsecaseMock);
        });
  });
}

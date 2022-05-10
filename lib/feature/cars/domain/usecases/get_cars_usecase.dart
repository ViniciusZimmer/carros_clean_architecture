import '../entities/cars_entity.dart';
import '../repositories/cars_repository.dart';

abstract class GetCarsUsecase {
  Future<List<CarsEntity>> call();
}

class GetCarsUsecaseImpl implements GetCarsUsecase {
  final CarsRepository _carsRepository;

  GetCarsUsecaseImpl({
    required CarsRepository carsRepository,
  }) : _carsRepository = carsRepository;

  @override
  Future<List<CarsEntity>> call() async {
    return await _carsRepository.getCars();
  }
}

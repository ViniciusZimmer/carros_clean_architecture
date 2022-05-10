import '../../domain/entities/cars_entity.dart';
import '../../domain/failures/failures.dart';
import '../../domain/repositories/cars_repository.dart';
import '../datasources/cars_datasource.dart';

class CarsRepositoryImpl implements CarsRepository {
  final CarsDatasource _carsDatasource;

  CarsRepositoryImpl({
    required CarsDatasource carsDatasource,
  }) : _carsDatasource = carsDatasource;

  @override
  Future<List<CarsEntity>> getCars() async {
    try {
      return await _carsDatasource.getCars();
    } on CarsFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownCarsFailure(
        stackTrace: stackTrace,
        label: 'CarsRepositoryImpl - getCars',
      );
    }
  }
}

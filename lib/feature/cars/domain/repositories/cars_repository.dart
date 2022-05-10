import '../entities/cars_entity.dart';

abstract class CarsRepository {
  Future<List<CarsEntity>> getCars();
}

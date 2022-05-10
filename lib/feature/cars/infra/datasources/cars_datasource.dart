import '../../domain/entities/cars_entity.dart';

abstract class CarsDatasource {
  Future<List<CarsEntity>> getCars();
}

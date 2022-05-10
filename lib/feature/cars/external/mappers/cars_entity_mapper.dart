import '../../domain/entities/cars_entity.dart';

class CarsEntityMapper {
  static CarsEntity fromMap({required Map<String, dynamic> map}) {
    return CarsEntity(
        id: map['id'],
        name: map['nome'],
        description: map['descricao'],
        type: map['tipo'],
        photoUrl: map['urlFoto']);
  }
}

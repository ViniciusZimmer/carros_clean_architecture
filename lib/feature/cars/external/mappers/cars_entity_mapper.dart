import '../../domain/entities/cars_entity.dart';

class CarsEntityMapper {
  static CarsEntity fromMap({required Map<String, dynamic> map}) {
    return CarsEntity(
      id: map['id'],
      nome: map['nome'],
      tipo: map['tipo'],
      descricao: map['descricao'],
      urlFoto: map['urlFoto'],
      urlVideo: map['urlVideo'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}

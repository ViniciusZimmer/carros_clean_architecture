import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/external/mappers/login_request_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toMap', () {
    test(
        'Verifica se retorna um Map a partir de uma entidade passando os respectivos parametros',
        () {
      //Arrange
      final LoginRequestEntity entity =
          LoginRequestEntity(login: 'teste', password: 'teste');
      //Act
      final result = LoginRequestEntityMapper.toMap(entity: entity);

      //Assert
      expect(result, <String, dynamic>{
        'username': 'teste',
        'password': 'teste',
      });
    });
  });
}

import 'package:clean_cars/feature/cars/domain/entities/cars_entity.dart';
import 'package:clean_cars/feature/cars/external/mappers/cars_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap', () {
    test(
        '''Deve retornar um CarsEntity com o parâmetro posterImageUrl = map["poster_path"] concatenada com url base do IMDB,
         convertendo o Map<String, dynamic> com todos os campos não nulos''',
        () {
      //Arrange
      final map = {
        'id': 1,
        'descricao': 'test',
        'urlFoto': 'https://image.tmdb.org/t/p/w300/teste',
        'tipo': 'teste',
        'nome': 'fiat'
      };

      //Act
      final result = CarsEntityMapper.fromMap(map: map);

      //Assert
      expect(
        result,
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
      );
    });

    test(
        '''Deve retornar um CarsEntity com o parâmetro posterImageUrl = map["poster_path"] concatenada com url base do IMDB,
         convertendo o Map<String, dynamic> com a chave "vote_average" igual a null''',
        () {
      //Arrange
      final map = {
        'id': 1,
        'descricao': 'test',
        'urlFoto': 'https://image.tmdb.org/t/p/w300/teste',
        'tipo': 'teste',
        'nome': 'fiat'
      };

      //Act
      final result = CarsEntityMapper.fromMap(map: map);

      //Assert
      expect(
        result,
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
      );
    });

    test(
        '''Deve retornar um CarsEntity com o parâmetro posterImageUrl = map["poster_path"] concatenada com url base do IMDB,
         convertendo o Map<String, dynamic> com a chave "vote_average" igual a um int''',
        () {
      //Arrange
      final map = {
        'id': 1,
        'descricao': 'test',
        'urlFoto': 'https://image.tmdb.org/t/p/w300/teste',
        'tipo': 'teste',
        'nome': 'fiat'
      };

      //Act
      final result = CarsEntityMapper.fromMap(map: map);

      //Assert
      expect(
        result,
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
      );
    });
  });
}

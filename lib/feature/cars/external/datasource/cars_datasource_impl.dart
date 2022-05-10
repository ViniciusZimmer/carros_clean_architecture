import 'package:dio/dio.dart';

import '../../domain/entities/cars_entity.dart';
import '../../domain/failures/failures.dart';
import '../../infra/datasources/cars_datasource.dart';
import '../mappers/cars_entity_mapper.dart';

class CarsDatasourceImpl implements CarsDatasource {
  final Dio _dio;

  CarsDatasourceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<List<CarsEntity>> getCars() async {
    try {
      final Response result = await _dio.get(
        'https://carros-springboot.herokuapp.com/api/v1/carros',
      );

      if (result.statusCode == 200) {
        final responseData = (result.data['result'] ?? []) as List;

        final cars = responseData
            .map((car) => CarsEntityMapper.fromMap(map: car))
            .toList();

        return cars;
      } else {
        throw DataSourceCarsFailure(
          errorMessage: result.data!['status_message'],
        );
      }
    } on DioError catch (error, stackTrace) {
      final List<DioErrorType> dioErrorTypes = [
        DioErrorType.connectTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetCarsFailure(
          stackTrace: stackTrace,
          label: 'CarsDatasourceImpl - getCars',
        );
      } else {
        throw UnknownCarsFailure(
          stackTrace: stackTrace,
          label: 'CarsDatasourceImpl - getCars',
        );
      }
    }
  }
}

import '../../domain/failures/login_failure.dart';
import '../mappers/login_request_entity_mapper.dart';
import '../mappers/user_info_entity_mapper.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/user_info_entity.dart';
import '../../infra/datasources/login_datasource.dart';

class LoginDatasourceImpl implements LoginDatasource {
  final Dio dio;

  LoginDatasourceImpl({
    required this.dio,
  });

  @override
  Future<UserInfoEntity> doLogin(
      {required LoginRequestEntity loginRequestEntity}) async {
    try {
      final Response result = await dio.post(
        'https://carros-springboot.herokuapp.com/api/v2/login',
        data: LoginRequestEntityMapper.toMap(
          entity: loginRequestEntity,
        ),
      );

      if (result.statusCode == 200) {
        final UserInfoEntity userInfoEntity = UserInfoEntityMapper.fromMap(
            map: result.data as Map<String, dynamic>);
        return userInfoEntity;
      } else {
        throw DataSourceLoginFailure(errorMessage: result.data!['error']);
      }
    } on DioError catch (error, stackTrace) {
      final List<DioErrorType> dioErrorTypes = [
        DioErrorType.connectTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ];
      if (dioErrorTypes.contains(error.type)) {
        throw NoInternetLoginFailure(
          stackTrace: stackTrace,
          label: 'LoginDatasourceImpl - doLogin',
        );
      } else {
        throw UnknownLoginFailure(
          stackTrace: stackTrace,
          label: 'LoginDatasourceImpl - doLogin',
        );
      }
    }
  }
}

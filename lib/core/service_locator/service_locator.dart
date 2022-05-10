import '../../feature/cars/domain/repositories/cars_repository.dart';
import '../../feature/cars/domain/usecases/get_cars_usecase.dart';
import '../../feature/cars/external/datasource/cars_datasource_impl.dart';
import '../../feature/cars/infra/datasources/cars_datasource.dart';
import '../../feature/cars/infra/repositories/cars_repository_impl.dart';
import '../../feature/cars/presenter/cubits/cars_cubit.dart';
import '../../feature/login/domain/repositories/login_repository.dart';
import '../../feature/login/domain/usecases/do_login_usecase.dart';
import '../../feature/login/external/datasources/login_datasource_impl.dart';
import '../../feature/login/infra/datasources/login_datasource.dart';
import '../../feature/login/infra/repositories/login_repository_impl.dart';
import '../../feature/login/presenter/cubits/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  //login feature
  getIt.registerFactory<Dio>(
    () => Dio(),
  );
  getIt.registerFactory<LoginDatasource>(
    () => LoginDatasourceImpl(
      dio: getIt(),
    ),
  );
  getIt.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(
      loginDatasource: getIt(),
    ),
  );
  getIt.registerFactory<DoLoginUsecase>(
    () => DoLoginUsecaseImpl(
      loginRepository: getIt(),
    ),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      usecase: getIt(),
    ),
  );

  //carros feature

  //datasource
  getIt.registerSingleton<CarsDatasource>(
    CarsDatasourceImpl(
      dio: getIt(),
    ),
  );

  getIt.registerSingleton<CarsRepository>(
    CarsRepositoryImpl(
      carsDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetCarsUsecase>(
    GetCarsUsecaseImpl(
      carsRepository: getIt(),
    ),
  );

  getIt.registerFactory<CarsCubit>(
    () => CarsCubit(getCarsUsecase: getIt()),
  );
}

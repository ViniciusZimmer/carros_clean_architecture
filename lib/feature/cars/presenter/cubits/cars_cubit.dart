import 'package:bloc/bloc.dart';

import '../../domain/failures/failures.dart';
import '../../domain/usecases/get_cars_usecase.dart';
import 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final GetCarsUsecase _getCarsUsecase;
  CarsCubit({
    required GetCarsUsecase getCarsUsecase,
  })  : _getCarsUsecase = getCarsUsecase,
        super(CarsInitialState());

  Future<void> getCars() async {
    emit(const CarsLoadingState());
    try {
      final result = await _getCarsUsecase.call();
      emit(CarsLoadedState(cars: result));
    } on CarsFailure catch (error) {
      emit(CarsErrorState(errorMessage: error.errorMessage));
    }
  }
}

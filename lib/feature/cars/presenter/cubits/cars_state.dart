import 'package:flutter/foundation.dart';

import '../../domain/entities/cars_entity.dart';

abstract class CarsState {
  const CarsState();
}

class CarsInitialState extends CarsState {}

//getCars
class CarsLoadingState extends CarsState {
  const CarsLoadingState();
}

class CarsLoadedState extends CarsState {
  final List<CarsEntity> cars;

  CarsLoadedState({required this.cars});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarsLoadedState && listEquals(other.cars, cars);
  }

  @override
  int get hashCode => cars.hashCode;
}

class CarsEmptyState extends CarsState {}

class CarsErrorState extends CarsState {
  final String errorMessage;

  CarsErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarsErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

//getCarsInfo
class CarsInfoLoadingState extends CarsState {}

class CarsInfoLoadedState extends CarsState {}

class CarsInfoErrorState extends CarsState {}

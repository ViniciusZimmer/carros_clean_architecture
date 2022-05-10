import '../../../../core/failures/failure.dart';

abstract class CarsFailure extends Failure {
  CarsFailure({
    String errorMessage = '',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class DataSourceCarsFailure extends CarsFailure {
  DataSourceCarsFailure({
    required String errorMessage,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class NoInternetCarsFailure extends CarsFailure {
  NoInternetCarsFailure({
    String errorMessage = 'Você esta sem internet, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class UnknownCarsFailure extends CarsFailure {
  UnknownCarsFailure({
    String errorMessage = 'Ocorreu um erro inesperado, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class InvalidCredentialsCarsFailure extends CarsFailure {
  InvalidCredentialsCarsFailure({
    String errorMessage = 'Credenciais invalidas, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

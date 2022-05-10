import '../../domain/entities/user_info_entity.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserInfoEntity user;

  LoginSuccessState({required this.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginSuccessState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

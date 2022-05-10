import 'package:bloc/bloc.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/user_info_entity.dart';
import '../../domain/failures/login_failure.dart';
import '../../domain/usecases/do_login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final DoLoginUsecase _usecase;

  LoginCubit({required DoLoginUsecase usecase})
      : _usecase = usecase,
        super(
          LoginInitialState(),
        );

  Future<void> doLogin(LoginRequestEntity loginRequest) async {
    emit(LoginLoadingState());

    try {
      final UserInfoEntity user =
          await _usecase.call(loginRequestEntity: loginRequest);

      emit(LoginSuccessState(user: user));
    } on LoginFailure catch (error) {
      emit(LoginErrorState(errorMessage: error.errorMessage));
    }
  }
}

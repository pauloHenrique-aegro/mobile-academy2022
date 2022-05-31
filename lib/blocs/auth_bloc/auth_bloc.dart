import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/repositories/user_repository.dart';
import './auth_event.dart';
import './auth_state.dart';
import '../../models/api_exception.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repo = UserRepository();

  AuthBloc(AuthLoginState initialState) : super(AuthLoginState()) {
    on<SwitchAuthModeEvent>((event, emit) => emit(_switchAuthMode()));

    on<LoginButtonPressed>((event, emit) async {
      emit(LoadingState());
      try {
        await _repo.login(event.email);
        emit(LoginSucessState());
      } on ApiException catch (e) {
        emit(LoginFailureState(e.toString()));
      }
    });

    on<SignUpButtonPressed>((event, emit) async {
      emit(LoadingState());
      try {
        await _repo.signUp(event.fullName, event.email);
        emit(SignUpSucessState());
      } on ApiException catch (e) {
        emit(SignUpFailureState(e.toString()));
      }
    });
  }

  AuthState _switchAuthMode() {
    var authMode;
    switch (state.runtimeType) {
      case AuthSignUpState:
        authMode = AuthLoginState();
        break;
      case AuthLoginState:
        authMode = AuthSignUpState();
    }
    return authMode;
  }
}

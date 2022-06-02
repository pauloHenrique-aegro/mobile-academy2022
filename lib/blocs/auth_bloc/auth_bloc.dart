import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/repositories/user_repository.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repo = UserRepository();

  AuthBloc(AuthLoginModeState initialState) : super(AuthLoginModeState()) {
    on<SwitchAuthModeEvent>((event, emit) => emit(_switchAuthMode()));

    on<LoginButtonPressed>((event, emit) async {
      emit(LoadingAuthState());
      try {
        await _repo.login(event.email);
        emit(LoginSucessState());
      } on Exception catch (e) {
        emit(AuthFailureState(e));
      }
    });

    on<SignUpButtonPressed>((event, emit) async {
      emit(LoadingAuthState());
      try {
        await _repo.signUp(event.fullName, event.email);
        emit(SignUpSucessState());
      } on Exception catch (e) {
        emit(AuthFailureState(e));
      }
    });
  }

  AuthState _switchAuthMode() {
    var authMode;
    if (state.runtimeType != AuthSignUpModeState) {
      authMode = AuthSignUpModeState();
    } else {
      authMode = AuthLoginModeState();
    }
    return authMode;
  }
}

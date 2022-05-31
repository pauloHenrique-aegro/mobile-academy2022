import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/repositories/user_repository.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repo = UserRepository();

  AuthBloc(AuthLoginState initialState) : super(AuthLoginState()) {
    on<SwitchAuthModeEvent>((event, emit) => emit(_switchAuthMode()));

    on<LoginButtonPressed>((event, emit) async {
      await _repo.login(event.email);
    });

    on<SignUpButtonPressed>((event, emit) async {
      await _repo.signUp(event.fullName, event.email);
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

import 'package:flutter_bloc/flutter_bloc.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthLoginState initialState) : super(AuthLoginState()) {
    on<SwitchAuthModeEvent>((event, emit) => emit(_switchAuthMode()));
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

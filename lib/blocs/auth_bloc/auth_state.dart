abstract class AuthState {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthSignUpState extends AuthState {}

class AuthLoginState extends AuthState {}

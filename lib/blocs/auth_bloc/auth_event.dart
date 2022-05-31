abstract class AuthEvent {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SwitchAuthModeEvent extends AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;

  LoginButtonPressed({required this.email});
}

class SignUpButtonPressed extends AuthEvent {
  final String fullName;
  final String email;

  SignUpButtonPressed({required this.fullName, required this.email});
}

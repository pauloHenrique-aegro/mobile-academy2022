import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthSignUpModeState extends AuthState {}

class AuthLoginModeState extends AuthState {}

class LoadingState extends AuthState {}

class LoginSucessState extends AuthState {}

class LoginFailureState extends AuthState {
  final Exception exception;

  const LoginFailureState(this.exception);
}

class SignUpSucessState extends AuthState {}

class SignUpFailureState extends AuthState {
  final Exception exception;

  const SignUpFailureState(this.exception);
}

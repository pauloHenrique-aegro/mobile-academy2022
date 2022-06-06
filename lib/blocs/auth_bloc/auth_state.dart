import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthSignUpModeState extends AuthState {}

class AuthLoginModeState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoginSuccessState extends AuthState {}

class AuthFailureState extends AuthState {
  final Exception exception;

  const AuthFailureState(this.exception);
}

class SignUpSuccessState extends AuthState {}

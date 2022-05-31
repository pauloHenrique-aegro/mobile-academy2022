import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthSignUpState extends AuthState {}

class AuthLoginState extends AuthState {}

class LoadingState extends AuthState {}

class LoginSucessState extends AuthState {}

class LoginFailureState extends AuthState {
  final String messageError;

  const LoginFailureState(this.messageError);
}

class SignUpSucessState extends AuthState {}

class SignUpFailureState extends AuthState {
  final String messageError;

  const SignUpFailureState(this.messageError);
}

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

class SignUpSucessState extends AuthState {}

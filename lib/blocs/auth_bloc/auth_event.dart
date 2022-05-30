abstract class AuthEvent {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SwitchAuthModeEvent extends AuthEvent {}


abstract class LoginState {}
class LoginInitializeState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;
  LoginErrorState(this.errorMessage);
}
class LoginValid extends LoginState {}
class LoginLoadingState extends LoginState {}


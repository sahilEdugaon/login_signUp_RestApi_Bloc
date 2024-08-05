
abstract class SignUpState {}
class SignUpInitializeState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorMessage;
  SignUpErrorState(this.errorMessage);
}
class SignUpValid extends SignUpState {}
class SignUpLoadingState extends SignUpState {}


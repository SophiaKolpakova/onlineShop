abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState(this.errorMessage);
}
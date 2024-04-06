part of 'login_bloc.dart';

class LoginEvent {}

class LoginWithEmailAndPasswordRequested extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordRequested(
      {required this.email, required this.password});
}

class LogoutRequested extends LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginWithGoogleRequested extends LoginEvent{

}

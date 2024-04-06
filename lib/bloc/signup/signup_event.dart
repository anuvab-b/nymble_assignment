part of 'signup_bloc.dart';

class SignupEvent {}

class SignupWithEmailAndPassword extends SignupEvent {
  final String email;
  final String password;

  SignupWithEmailAndPassword({required this.email, required this.password});
}

class SignupEmailChanged extends SignupEvent {
  final String email;

  SignupEmailChanged({required this.email});
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  SignupPasswordChanged({required this.password});
}

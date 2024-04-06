part of 'login_bloc.dart';

class LoginState {
  final String? email;
  final String? userPassword;
  final bool isLoginEmailValid;
  final bool isLoginPasswordValid;

  LoginState(
      {this.email,
      this.userPassword,
      required this.isLoginEmailValid,
      required this.isLoginPasswordValid});

  LoginState copyWith(
      {String? email,
      String? userPassword,
      bool? isLoginEmailValid,
      bool? isLoginPasswordValid}) {
    return LoginState(
        isLoginEmailValid: isLoginEmailValid ?? this.isLoginEmailValid,
        isLoginPasswordValid: isLoginPasswordValid ?? this.isLoginPasswordValid,
        email: email ?? this.email,
        userPassword: userPassword ?? this.userPassword);
  }
}

class LoginInitial extends LoginState {
  LoginInitial(
      {required super.email,
      required super.userPassword,
      required super.isLoginEmailValid,
      required super.isLoginPasswordValid});
}

class LoginSuccess extends LoginState {
  final UserCredential userCredential;

  LoginSuccess(
      {required this.userCredential,
      required super.isLoginEmailValid,
      required super.isLoginPasswordValid});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(
      {required this.error,
      required super.isLoginEmailValid,
      required super.isLoginPasswordValid});
}

class LogoutFailure extends LoginState {
  final String error;

  LogoutFailure(
      {required this.error,
      required super.isLoginEmailValid,
      required super.isLoginPasswordValid});
}

class LoginLoading extends LoginState {
  LoginLoading(
      {required super.isLoginEmailValid, required super.isLoginPasswordValid});
}

class LoginLoaded extends LoginState {
  LoginLoaded(
      {required super.isLoginEmailValid, required super.isLoginPasswordValid});
}

part of 'signup_bloc.dart';

class SignupState {
  final String? email;
  final String? userPassword;
  final bool isSignupEmailValid;
  final bool isSignupPasswordValid;

  SignupState(
      {this.email,
        this.userPassword,
        required this.isSignupEmailValid,
        required this.isSignupPasswordValid});

  SignupState copyWith(
      {String? email,
        String? userPassword,
        bool? isSignupEmailValid,
        bool? isSignupPasswordValid}) {
    return SignupState(
        isSignupEmailValid: isSignupEmailValid ?? this.isSignupEmailValid,
        isSignupPasswordValid:
        isSignupPasswordValid ?? this.isSignupPasswordValid,
        email: email ?? this.email,
        userPassword: userPassword ?? this.userPassword);
  }
}

class SignupInitial extends SignupState {
  SignupInitial(
      {required super.isSignupEmailValid,
        required super.isSignupPasswordValid});
}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure(
      {required this.error,
        required super.isSignupEmailValid,
        required super.isSignupPasswordValid});
}

class SignupLoading extends SignupState {
  SignupLoading(
      {required super.isSignupEmailValid,
        required super.isSignupPasswordValid});
}

class SignupLoaded extends SignupState {
  SignupLoaded(
      {required super.isSignupEmailValid,
        required super.isSignupPasswordValid});
}

class SignupSuccess extends SignupState {
  final UserCredential userCredential;

  SignupSuccess(
      {required this.userCredential,
        required super.isSignupEmailValid,
        required super.isSignupPasswordValid});
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/domain/i_auth_repository.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final IAuthRepository authRepository;

  SignupBloc(this.authRepository)
      : super(SignupInitial(
      isSignupEmailValid: false, isSignupPasswordValid: false)) {
    on<SignupEmailChanged>(onSignupEmailChanged);
    on<SignupPasswordChanged>(onSignupPasswordChanged);
    on<SignupWithEmailAndPassword>(onSignupWithEmailAndPassword);
  }

  onSignupEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) {
    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email);
    emit(state.copyWith(email: event.email, isSignupEmailValid: emailValid));
  }

  onSignupPasswordChanged(
      SignupPasswordChanged event, Emitter<SignupState> emit) {
    final bool passwordValid =
    RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
        .hasMatch(event.password);
    emit(state.copyWith(
        userPassword: event.password, isSignupPasswordValid: passwordValid));
  }

  onSignupWithEmailAndPassword(
      SignupWithEmailAndPassword event, Emitter<SignupState> emit) async {
    try {
      if (!(state.isSignupEmailValid || state.isSignupPasswordValid)) {
        emit(SignupFailure(
            error: "Please ensure that you enter a valid email id & password",
            isSignupEmailValid: state.isSignupEmailValid,
            isSignupPasswordValid: state.isSignupPasswordValid));
      } else {
        emit(SignupLoading(
            isSignupEmailValid: state.isSignupEmailValid,
            isSignupPasswordValid: state.isSignupPasswordValid));
        final UserCredential userCredential = await authRepository
            .signUpWithUserIdAndPassword(event.email, event.password);
        emit(SignupLoaded(
            isSignupEmailValid: state.isSignupEmailValid,
            isSignupPasswordValid: state.isSignupPasswordValid));
        emit(SignupSuccess(
          userCredential: userCredential,
          isSignupEmailValid: true,
          isSignupPasswordValid: true,
        ));
      }
    } catch (e) {
      emit(SignupLoaded(
          isSignupEmailValid: state.isSignupEmailValid,
          isSignupPasswordValid: state.isSignupPasswordValid));
      emit(SignupFailure(
          error: e.toString(),
          isSignupPasswordValid: state.isSignupPasswordValid,
          isSignupEmailValid: state.isSignupEmailValid));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nymble_assignment/utils/secure_storage_manager.dart';
import 'package:nymble_assignment/domain/i_auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository authRepository;

  LoginBloc(this.authRepository)
      : super(LoginInitial(
            email: "",
            userPassword: "",
            isLoginEmailValid: false,
            isLoginPasswordValid: false)) {
    on<LoginWithEmailAndPasswordRequested>(signInWithUserIdAndPassword);
    on<LogoutRequested>(logoutUser);
    on<LoginEmailChanged>(onUserEmailChanged);
    on<LoginPasswordChanged>(onUserPasswordChanged);
    on<LoginWithGoogleRequested>(signInWithGoogle);
  }

  onUserEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email);
    emit(state.copyWith(email: event.email, isLoginEmailValid: emailValid));
  }

  onUserPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final bool passwordValid =
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
            .hasMatch(event.password);
    emit(state.copyWith(
        userPassword: event.password, isLoginPasswordValid: passwordValid));
  }

  Future<void> signInWithUserIdAndPassword(
      LoginWithEmailAndPasswordRequested event,
      Emitter<LoginState> emit) async {
    try {
      if (!(state.isLoginEmailValid || state.isLoginPasswordValid)) {
        emit(LoginFailure(
            error: "Please ensure that you enter a valid email id & password",
            isLoginEmailValid: state.isLoginEmailValid,
            isLoginPasswordValid: state.isLoginPasswordValid));
      } else {
        emit(LoginLoading(
            isLoginEmailValid: state.isLoginEmailValid,
            isLoginPasswordValid: state.isLoginPasswordValid));
        final UserCredential userCredential = await authRepository
            .signInWithUserIdAndPassword(event.email, event.password);
        emit(LoginLoaded(
            isLoginEmailValid: state.isLoginEmailValid,
            isLoginPasswordValid: state.isLoginPasswordValid));
        await SecureStorageManager()
            .writeSecureStorageData("user_id", userCredential.user?.email);
        emit(LoginSuccess(
          userCredential: userCredential,
          isLoginEmailValid: true,
          isLoginPasswordValid: true,
        ));
      }
    } catch (e) {
      emit(LoginFailure(
          error: e.toString(),
          isLoginEmailValid: state.isLoginEmailValid,
          isLoginPasswordValid: state.isLoginPasswordValid));
    }
  }

  Future<void> logoutUser(
      LogoutRequested event, Emitter<LoginState> emit) async {
    try {
      await authRepository.logoutUser();
      emit(LoginInitial(
          email: "",
          userPassword: "",
          isLoginEmailValid: false,
          isLoginPasswordValid: false));
    } catch (e) {
      emit(LogoutFailure(
          error: e.toString(),
          isLoginEmailValid: false,
          isLoginPasswordValid: false));
    }
  }

  Future<void> signInWithGoogle(
      LoginWithGoogleRequested event,
      Emitter<LoginState> emit) async {
    try {
        emit(LoginLoading(
            isLoginEmailValid: state.isLoginEmailValid,
            isLoginPasswordValid: state.isLoginPasswordValid));
        final UserCredential userCredential = await authRepository
            .signInWithGoogle();
        emit(LoginLoaded(
            isLoginEmailValid: state.isLoginEmailValid,
            isLoginPasswordValid: state.isLoginPasswordValid));
        await SecureStorageManager()
            .writeSecureStorageData("user_id", userCredential.user?.email);
        emit(LoginSuccess(
          userCredential: userCredential,
          isLoginEmailValid: true,
          isLoginPasswordValid: true,
        ));
    } catch (e) {
      emit(LoginFailure(
          error: e.toString(),
          isLoginEmailValid: state.isLoginEmailValid,
          isLoginPasswordValid: state.isLoginPasswordValid));
    }
  }
}

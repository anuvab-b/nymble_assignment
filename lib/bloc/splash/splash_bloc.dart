import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/utils/secure_storage_manager.dart';

part 'splash_event.dart';
part 'splash_state.dart';
class SplashBloc extends Bloc<SplashEvent,SplashState>{
  SplashBloc():super(SplashInit()){
    on<OnSplashInit>(onSplashInit);
    on<OnNavigateFromSplash>(onNavigateFromSplash);
  }

  onSplashInit(OnSplashInit event, Emitter<SplashState> emit){

  }

  onNavigateFromSplash(OnNavigateFromSplash event, Emitter<SplashState> emit)async{
    String? userId =
        await SecureStorageManager().readSecureStorageData("user_id");
    await Future.delayed(const Duration(milliseconds: 300));
    if (userId != null) {
      debugPrint("emit SplashAuthenticated");
      emit(SplashAuthenticated());
    } else {
      debugPrint("emit SplashUnauthenticated");
      emit(SplashUnAuthenticated());
    }
  }
}
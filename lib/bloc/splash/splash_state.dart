part of 'splash_bloc.dart';

abstract class SplashState{}

class SplashInit extends SplashState{}
class SplashLoading extends SplashState{}
class SplashAuthenticated extends SplashState{}
class SplashUnAuthenticated extends SplashState{}
import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:nymble_assignment/domain/i_auth_repository.dart';
import 'package:nymble_assignment/domain/i_music_repository.dart';
import 'package:nymble_assignment/infrastructure/auth_repository.dart';
import 'package:nymble_assignment/infrastructure/music_repository.dart';

final getIt = GetIt.instance;
class ServiceLocator{

  static init(){
    getIt.registerSingleton<IMusicRepository>(MusicRepository());
    getIt.registerSingleton<IAuthRepository>(AuthRepository());
    getIt.registerSingleton<AudioPlayer>(AudioPlayer());
   }
}
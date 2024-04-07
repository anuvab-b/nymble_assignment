import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, MyPlayerState> {
  final AudioPlayer audioPlayer;

  PlayerBloc(this.audioPlayer)
      : super(PlayerInit(
            isPlaying: false,
            selectedModel: null,
            position: const Duration(seconds: 0),
            duration: const Duration(seconds: 0))) {
    on<PlayerOnPaused>(onPlayerPaused);
    on<PlayerStartOrResume>(onPlayerStartOrResume);
    on<PlayerStop>(onPlayerStop);
  }

  onPlayerPaused(PlayerOnPaused event, Emitter<MyPlayerState> emit) {
    audioPlayer.pause();
    emit(PlayerPlay(
        isPlaying: false,
        selectedModel: event.selectedModel,
        duration: state.duration,
        position: state.position));
    // audioPlayer.onDurationChanged.listen((event) {
    //   emit(state.copyWith(duration: event));
    // });
    // audioPlayer.onPositionChanged.listen((event) {
    //   emit(state.copyWith(position: event));
    // });
  }

  onPlayerStartOrResume(
      PlayerStartOrResume event, Emitter<MyPlayerState> emit) async {
    await audioPlayer.play(UrlSource(event.url));
    emit(PlayerPlay(
        isPlaying: true,
        selectedModel: event.selectedModel,
        duration: state.duration,
        position: state.position));
    // audioPlayer.onDurationChanged.listen((event) {
    //   emit(state.copyWith(duration: event));
    // });
    // audioPlayer.onPositionChanged.listen((event) {
    //   emit(state.copyWith(position: event));
    // });
  }

  onPlayerStop(PlayerStop event, Emitter<MyPlayerState> emit)async{
    if(audioPlayer.state!=PlayerState.stopped) {
      await audioPlayer.stop();
      await audioPlayer.dispose();
    }
  }
}

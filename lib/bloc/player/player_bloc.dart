import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, MyPlayerState> {
  final AudioPlayer audioPlayer;

  PlayerBloc(this.audioPlayer)
      : super(PlayerInit(
            isPlaying: false,
            selectedIndex: -1,
            position: const Duration(seconds: 0),
            duration: const Duration(seconds: 0))) {
    on<PlayerOnPaused>(onPlayerPaused);
    on<PlayerStartOrResume>(onPlayerStartOrResume);
  }

  onPlayerPaused(PlayerOnPaused event, Emitter<MyPlayerState> emit) {
    audioPlayer.pause();
    emit(PlayerPlay(
        isPlaying: false,
        selectedIndex: event.index,
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
        selectedIndex: event.index,
        duration: state.duration,
        position: state.position));
    // audioPlayer.onDurationChanged.listen((event) {
    //   emit(state.copyWith(duration: event));
    // });
    // audioPlayer.onPositionChanged.listen((event) {
    //   emit(state.copyWith(position: event));
    // });
  }
}

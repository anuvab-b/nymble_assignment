part of 'player_bloc.dart';

class MyPlayerState {
  final bool isPlaying;
  final MusicModel? selectedModel;
  Duration duration;
  Duration position;

  MyPlayerState(
      {required this.isPlaying,
      required this.selectedModel,
      required this.duration,
      required this.position});

  MyPlayerState copyWith(
      {bool? isPlaying,
      MusicModel? selectedModel,
      Duration? duration,
      Duration? position}) {
    return MyPlayerState(
        isPlaying: isPlaying ?? this.isPlaying,
        selectedModel: selectedModel ?? this.selectedModel,
        position: position ?? this.position,
        duration: duration ?? this.duration);
  }
}

class PlayerInit extends MyPlayerState {
  PlayerInit(
      {required super.isPlaying,
      required super.selectedModel,
      required super.duration,
      required super.position});
}

class PlayerPlay extends MyPlayerState {
  PlayerPlay(
      {required super.isPlaying,
      required super.selectedModel,
      required super.duration,
      required super.position});
}

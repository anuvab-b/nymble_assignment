part of 'player_bloc.dart';

class MyPlayerState {
  final bool isPlaying;
  final int selectedIndex;
  Duration duration;
  Duration position;

  MyPlayerState(
      {required this.isPlaying,
      required this.selectedIndex,
      required this.duration,
      required this.position});

  MyPlayerState copyWith(
      {bool? isPlaying,
      int? selectedIndex,
      Duration? duration,
      Duration? position}) {
    return MyPlayerState(
        isPlaying: isPlaying ?? this.isPlaying,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        position: position ?? this.position,
        duration: duration ?? this.duration);
  }
}

class PlayerInit extends MyPlayerState {
  PlayerInit(
      {required super.isPlaying,
      required super.selectedIndex,
      required super.duration,
      required super.position});
}

class PlayerPlay extends MyPlayerState {
  PlayerPlay(
      {required super.isPlaying,
      required super.selectedIndex,
      required super.duration,
      required super.position});
}

part of 'player_bloc.dart';

class PlayerEvent {}

class PlayerOnPaused extends PlayerEvent {
  MusicModel selectedModel;

  PlayerOnPaused({required this.selectedModel});
}

class PlayerStartOrResume extends PlayerEvent {
  String url;
  MusicModel selectedModel;

  PlayerStartOrResume({required this.url, required this.selectedModel});
}

class PlayerStop extends PlayerEvent {
  PlayerStop();
}

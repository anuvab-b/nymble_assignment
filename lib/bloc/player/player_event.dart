part of 'player_bloc.dart';

class PlayerEvent {}

class PlayerOnPaused extends PlayerEvent {
  int index;

  PlayerOnPaused({required this.index});
}

class PlayerStartOrResume extends PlayerEvent {
  String url;
  int index;

  PlayerStartOrResume({required this.url,required this.index});
}

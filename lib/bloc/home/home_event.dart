part of 'home_bloc.dart';

class HomeEvent {}

class OnHomeInit extends HomeEvent {}

class ListItemPress extends HomeEvent {
  int itemIndex;

  ListItemPress({required this.itemIndex});
}

class ListItemLikePress extends HomeEvent {
  bool isLiked;
  String url;
  int index;

  ListItemLikePress(
      {required this.index, required this.url, required this.isLiked});
}

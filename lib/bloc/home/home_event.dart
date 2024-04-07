part of 'home_bloc.dart';

class HomeEvent {}

class OnHomeInit extends HomeEvent {}

class ListItemPress extends HomeEvent {
  MusicModel selectedModel;

  ListItemPress({required this.selectedModel});
}

class ListItemLikePress extends HomeEvent {
  bool isLiked;
  String url;
  int index;

  ListItemLikePress(
      {required this.index, required this.url, required this.isLiked});
}

class FavouriteItemPress extends HomeEvent {
  String url;
  int index;

  FavouriteItemPress(
      {required this.index, required this.url});
}

class OnSearchTextChange extends HomeEvent{
  String searchText;
  OnSearchTextChange({required this.searchText});
}

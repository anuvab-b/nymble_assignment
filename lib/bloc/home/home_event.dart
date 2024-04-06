part of 'home_bloc.dart';

class HomeEvent {}

class OnHomeInit extends HomeEvent{

}
class ListItemPress extends HomeEvent {
  int itemIndex;

  ListItemPress({required this.itemIndex});
}

class ListItemLikePress extends HomeEvent {
  int itemIndex;

  ListItemLikePress({required this.itemIndex});
}

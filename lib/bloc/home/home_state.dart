part of 'home_bloc.dart';

class HomeState {
  final List<MusicModel> musicList;
  final List<MusicModel> favouritesList;
  final int? selectedIndex;

  const HomeState({this.selectedIndex,required this.musicList,required this.favouritesList});

  HomeState copyWith(
      {List<MusicModel>? musicList,
      int? selectedIndex,
      List<MusicModel>? favouritesList}) {
    return HomeState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        musicList: musicList ?? this.musicList,
        favouritesList: favouritesList ?? this.favouritesList);
  }
}

class HomeLoading extends HomeState {
  const HomeLoading({required super.musicList, required super.favouritesList});
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.musicList, required super.favouritesList});
}

class HomeSuccess extends HomeState {
  HomeSuccess({super.selectedIndex, required super.musicList, required super.favouritesList});

  @override
  HomeSuccess copyWith(
      {List<MusicModel>? musicList,
      int? selectedIndex,
      List<MusicModel>? favouritesList}) {
    return HomeSuccess(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        musicList: musicList ?? this.musicList,
        favouritesList: favouritesList ?? this.favouritesList);
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message, required super.musicList, required super.favouritesList});
}

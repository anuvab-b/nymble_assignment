part of 'home_bloc.dart';

class HomeState {
  final List<MusicModel> musicList;
  final List<MusicModel> favouritesList;
  final MusicModel? selectedModel;

  const HomeState({this.selectedModel,required this.musicList,required this.favouritesList});

  HomeState copyWith(
      {List<MusicModel>? musicList,
        MusicModel? selectedModel,
      List<MusicModel>? favouritesList}) {
    return HomeState(
        selectedModel: selectedModel ?? this.selectedModel,
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
  HomeSuccess({super.selectedModel, required super.musicList, required super.favouritesList});

  @override
  HomeSuccess copyWith(
      {List<MusicModel>? musicList,
        MusicModel? selectedModel,
      List<MusicModel>? favouritesList}) {
    return HomeSuccess(
        selectedModel: selectedModel ?? this.selectedModel,
        musicList: musicList ?? this.musicList,
        favouritesList: favouritesList ?? this.favouritesList);
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message, required super.musicList, required super.favouritesList});
}

part of 'home_bloc.dart';

class HomeState {
  final List<MusicModel> musicList;
  final List<MusicModel> favouritesList;
  final List<MusicModel> searchMusicList;
  final List<MusicModel> searchFavouritesList;
  final MusicModel? selectedModel;

  const HomeState(
      {this.selectedModel,
      required this.musicList,
      required this.favouritesList,
      required this.searchMusicList,
      required this.searchFavouritesList});

  HomeState copyWith(
      {List<MusicModel>? musicList,
      MusicModel? selectedModel,
      List<MusicModel>? favouritesList,
      List<MusicModel>? searchMusicList,
      List<MusicModel>? searchFavouritesList}) {
    return HomeState(
      selectedModel: selectedModel ?? this.selectedModel,
      musicList: musicList ?? this.musicList,
      favouritesList: favouritesList ?? this.favouritesList,
      searchMusicList: musicList ?? this.searchMusicList,
      searchFavouritesList: favouritesList ?? this.searchFavouritesList,
    );
  }
}

class HomeLoading extends HomeState {
  const HomeLoading({
    required super.musicList,
    required super.favouritesList,
    required super.searchMusicList,
    required super.searchFavouritesList,
  });
}

class HomeInitial extends HomeState {
  const HomeInitial(
      {required super.musicList,
      required super.favouritesList,
      required super.searchMusicList,
      required super.searchFavouritesList});
}

class HomeSuccess extends HomeState {
  HomeSuccess(
      {super.selectedModel,
      required super.musicList,
      required super.favouritesList,
      required super.searchMusicList,
      required super.searchFavouritesList});

  @override
  HomeSuccess copyWith(
      {List<MusicModel>? musicList,
      MusicModel? selectedModel,
      List<MusicModel>? favouritesList,
      List<MusicModel>? searchMusicList,
      List<MusicModel>? searchFavouritesList}) {
    return HomeSuccess(
        selectedModel: selectedModel ?? this.selectedModel,
        musicList: musicList ?? this.musicList,
        favouritesList: favouritesList ?? this.favouritesList,
        searchMusicList: searchMusicList ?? this.searchMusicList,
        searchFavouritesList:
            searchFavouritesList ?? this.searchFavouritesList);
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(
      {required this.message,
      required super.musicList,
      required super.favouritesList,
      required super.searchMusicList,
      required super.searchFavouritesList});
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/domain/i_music_repository.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IMusicRepository musicRepository;
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  HomeBloc(this.musicRepository)
      : super(const HomeInitial(
            favouritesList: [],
            musicList: [],
            searchFavouritesList: [],
            searchMusicList: [])) {
    on<OnHomeInit>(onListInit);
    on<ListItemPress>(onListItemPress);
    on<ListItemLikePress>(onListItemLikePress);
    on<FavouriteItemPress>(onFavouriteItemPress);
    on<OnSearchTextChange>(onSearchTextChange);
  }

  onListItemPress(ListItemPress event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedModel: event.selectedModel));
  }

  onListItemLikePress(ListItemLikePress event, Emitter<HomeState> emit) async {
    try {
      List<MusicModel> favourites = state.favouritesList;
      final User? user = FirebaseAuth.instance.currentUser;
      if (!event.isLiked) {
        favourites.add(state.musicList[event.index]);
      } else {
        favourites.removeWhere((element) => element.url == event.url);
      }
      MusicListModel musicListModel = MusicListModel(result: favourites);
      await musicRepository.updateFavourites(user!, musicListModel);
      List results = await Future.wait([
        musicRepository.getMusicList(),
        musicRepository.getFavouritesList(user)
      ]);
      List<MusicModel> musicList = results[0];
      List<MusicModel> favouritesMusicList = results[1];
      List<String> favouriteStrings =
          favouritesMusicList.map((e) => e.url).toList();
      for (var music in musicList) {
        if (favouriteStrings.contains(music.url)) {
          music.isLiked = true;
        } else {
          music.isLiked = false;
        }
      }
      emit(state.copyWith(
          musicList: musicList,
          favouritesList: favourites,
          searchMusicList: musicList,
          searchFavouritesList: favouritesMusicList));
    } catch (e) {
      emit(HomeError(
          message: e.toString(),
          musicList: [],
          favouritesList: [],
          searchFavouritesList: [],
          searchMusicList: []));
    }
  }

  onFavouriteItemPress(
      FavouriteItemPress event, Emitter<HomeState> emit) async {
    try {
      List<MusicModel> favourites = state.favouritesList;
      final User? user = FirebaseAuth.instance.currentUser;
      favourites.removeWhere((element) => element.url == event.url);
      MusicListModel musicListModel = MusicListModel(result: favourites);
      await musicRepository.updateFavourites(user!, musicListModel);
      List results = await Future.wait([
        musicRepository.getMusicList(),
        musicRepository.getFavouritesList(user)
      ]);
      List<MusicModel> musicList = results[0];
      favourites = results[1];
      List<String> favouriteStrings = favourites.map((e) => e.url).toList();
      for (var music in musicList) {
        if (favouriteStrings.contains(music.url)) {
          music.isLiked = true;
        } else {
          music.isLiked = false;
        }
      }
      emit(state.copyWith(
          musicList: musicList,
          favouritesList: favourites,
          searchFavouritesList: favourites,
          searchMusicList: musicList));
    } catch (e) {
      emit(HomeError(
          message: e.toString(),
          musicList: [],
          favouritesList: [],
          searchMusicList: [],
          searchFavouritesList: []));
    }
  }

  onListInit(OnHomeInit event, Emitter<HomeState> emit) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      emit(const HomeLoading(
          musicList: [],
          favouritesList: [],
          searchFavouritesList: [],
          searchMusicList: []));
      List results = await Future.wait([
        musicRepository.getMusicList(),
        musicRepository.getFavouritesList(user!)
      ]);
      List<MusicModel> musicList = results[0];
      List<MusicModel> favouritesMusicList = results[1];
      List<String> favourites = favouritesMusicList.map((e) => e.url).toList();
      for (var music in musicList) {
        if (favourites.contains(music.url)) {
          music.isLiked = true;
        }
      }
      emit(HomeSuccess(
          selectedModel: null,
          musicList: musicList,
          favouritesList: favouritesMusicList,
          searchMusicList: musicList,
          searchFavouritesList: favouritesMusicList));
    } catch (e) {
      emit(HomeError(
          message: "Error",
          musicList: [],
          favouritesList: [],
          searchMusicList: [],
          searchFavouritesList: []));
    }
  }

  onSearchTextChange(OnSearchTextChange event, Emitter<HomeState> emit) {
    String searchText = event.searchText.toLowerCase();
    emit(state.copyWith(
        searchFavouritesList: state.favouritesList
            .where((element) =>
                (element.artist.toLowerCase().contains(searchText) ||
                    element.title.toLowerCase().contains(searchText)))
            .toList(),
        searchMusicList: state.musicList
            .where((element) =>
                (element.artist.toLowerCase().contains(searchText) ||
                    element.title.toLowerCase().contains(searchText)))
            .toList()));
  }
}

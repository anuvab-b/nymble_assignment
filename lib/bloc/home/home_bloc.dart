import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/domain/i_music_repository.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IMusicRepository musicRepository;

  HomeBloc(this.musicRepository)
      : super(const HomeInitial(favouritesList: [], musicList: [])) {
    on<OnHomeInit>(onListInit);
    on<ListItemPress>(onListItemPress);
    on<ListItemLikePress>(onListItemLikePress);
  }

  onListItemPress(ListItemPress event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedIndex: event.itemIndex));
  }

  onListItemLikePress(ListItemLikePress event, Emitter<HomeState> emit) {
    List<MusicModel> favourites = state.favouritesList;
    if (!event.isLiked) {
      favourites.add(state.musicList[event.index]);
    } else {
      favourites.removeWhere((element) => element.url == event.url);
    }
    // List results = await Future.wait(
    //     [musicRepository.getMusicList(), musicRepository.getFavouritesList()]);
    List<MusicModel> musicList = state.musicList;
    List<String> favouriteStrings = state.favouritesList.map((e) => e.url).toList();
    // List<MusicModel> favouritesMusicList = results[1];
    // List<String> favourites =
    // favouritesMusicList.map((e) => e.coverUrl).toList();
    for (var music in musicList) {
      if (favouriteStrings.contains(music.url)) {
        music.isLiked = true;
      } else {
        music.isLiked = false;
      }
    }
    emit(state.copyWith(favouritesList: favourites));
  }

  onListInit(OnHomeInit event, Emitter<HomeState> emit) async {
    emit(const HomeLoading(musicList: [], favouritesList: []));
    List results = await Future.wait(
        [musicRepository.getMusicList(), musicRepository.getFavouritesList()]);
    List<MusicModel> musicList = results[0];
    List<MusicModel> favouritesMusicList = results[1];
    List<String> favourites = favouritesMusicList.map((e) => e.url).toList();
    for (var music in musicList) {
      if (favourites.contains(music.url)) {
        music.isLiked = true;
      }
    }
    emit(HomeSuccess(
        selectedIndex: -1, musicList: musicList, favouritesList: favouritesMusicList));
  }
}

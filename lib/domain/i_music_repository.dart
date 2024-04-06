import 'package:nymble_assignment/domain/music_list_model.dart';

abstract class IMusicRepository {
  Future<List<MusicModel>> getMusicList();
  Future<List<MusicModel>> getFavouritesList();
  Future<List<MusicModel>> updateFavourites(List<MusicModel> musicList);
}
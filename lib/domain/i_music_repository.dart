import 'package:firebase_auth/firebase_auth.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

abstract class IMusicRepository {
  Future<List<MusicModel>> getMusicList();
  Future<List<MusicModel>> getFavouritesList(User user);
  Future<void> updateFavourites(User user, MusicListModel musicListModel);
}
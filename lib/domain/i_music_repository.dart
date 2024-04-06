import 'package:nymble_assignment/domain/music_list_model.dart';

abstract class IMusicRepository {
  Future<List<MusicModel>> getMusicList();
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nymble_assignment/domain/i_music_repository.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';
import 'dart:convert';

class MusicRepository implements IMusicRepository {
  @override
  Future<List<MusicModel>> getMusicList() async {
    try {
      final String localResponse =
      await rootBundle.loadString("assets/json/data.json");
      final data = json.decode(localResponse);
      return MusicListModel
          .fromJson(data)
          .result;
    }
    catch(e){
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}

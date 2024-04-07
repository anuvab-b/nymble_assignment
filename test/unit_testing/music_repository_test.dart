import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:nymble_assignment/domain/music_list_model.dart';

@GenerateMocks([http.Client])
void main() {
  group("Music Repository - ", () {
    group("getMusicList function - ", () {
      test(
          "Given MusicRepository class when getMusicList is called and response is success, a MusicListModel should be returned",
          () async {
            final file = File('assets/json/data.json').readAsStringSync();
            final musicList =
            MusicListModel.fromJson(jsonDecode(file) as Map<String, dynamic>);
            expect(musicList.result, isA<List<MusicModel>>());
            expect(musicList.result.length, 35);
      });
    });
  });
}

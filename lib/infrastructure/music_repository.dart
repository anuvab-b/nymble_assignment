import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      return MusicListModel.fromJson(data).result;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<MusicModel>> getFavouritesList(User user) async {
    List<MusicModel> favourites = List.empty(growable: true);

    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await db
          .collection("users")
          .doc(user.email)
          .collection("favourites")
          .doc("songs")
          .get()
          .catchError((e) {
        debugPrint(e.toString());
        return e;
      });
      if (snapshot.data() != null) {
        Map<String, dynamic>? documentData =
            snapshot.data() as Map<String, dynamic>;
        favourites = MusicListModel.fromJson(documentData).result;
      }
      return favourites;
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<void> updateFavourites(
      User user, MusicListModel musicListModel) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db
          .collection("users")
          .doc(user.email)
          .collection("favourites")
          .doc("songs")
          .set(musicListModel.toJson());
    } catch (e) {
      throw (e.toString());
    }
  }
}

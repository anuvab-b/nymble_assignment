import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

class MusicDetailsScreen extends StatelessWidget {
  final MusicModel musicModel;

  const MusicDetailsScreen({Key? key, required this.musicModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tags = musicModel.tags.split(",");
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(
                  children: [
                    Hero(
                      tag: musicModel.url,
                      child: CachedNetworkImage(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                          imageUrl: musicModel.coverUrl),
                    ),
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  musicModel.title,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900),
                                )))),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: tags.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                child: Chip(
                                  padding: const EdgeInsets.all(4),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shadowColor:
                                      Theme.of(context).primaryColorLight,
                                  label: Text(
                                    tags[index],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ), //Text
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ])
            ])));
  }
}

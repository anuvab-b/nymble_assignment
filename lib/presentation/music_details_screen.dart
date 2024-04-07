import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/home/home_bloc.dart';
import 'package:nymble_assignment/bloc/player/player_bloc.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

class MusicDetailsScreen extends StatelessWidget {
  final MusicModel musicModel;

  const MusicDetailsScreen({Key? key, required this.musicModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tags = musicModel.tags.split(",");
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Hero(
                          tag: musicModel.url,
                          child: SizedBox(
                              width: 300,
                              height: 400,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      value: progress.progress,
                                    ),
                                  ),
                                  imageUrl: musicModel.coverUrl,
                                ),
                              ))),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      musicModel.title,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      musicModel.artist,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            BlocBuilder<PlayerBloc, MyPlayerState>(builder: (context, mState) {
              HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
              PlayerBloc playerBloc = BlocProvider.of<PlayerBloc>(context);
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: IconButton(
                    onPressed: () {
                      if (mState.isPlaying) {
                        if (homeBloc.state.selectedModel != null) {
                          playerBloc.add(PlayerOnPaused(
                              selectedModel: homeBloc.state.selectedModel!));
                        }
                      } else {
                        if (homeBloc.state.selectedModel != null) {
                          playerBloc.add(PlayerStartOrResume(
                              url: homeBloc.state.selectedModel!.url,
                              selectedModel: homeBloc.state.selectedModel!));
                        }
                      }
                    },
                    iconSize: 40.0,
                    icon: mState.isPlaying
                        ? const Icon(Icons.pause_rounded)
                        : const Icon(Icons.play_arrow)),
              );
            }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Wrap(
                  alignment: WrapAlignment.start,
                  children: tags
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              padding: const EdgeInsets.all(4),
                              backgroundColor: AppColors.darkThemeSecondary,
                              shadowColor: AppColors.darkThemeSecondary,
                              label: Text(
                                "#$e",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ), //Text
                            ),
                          ))
                      .toList()),
            ),
          ])),
    ));
  }
}

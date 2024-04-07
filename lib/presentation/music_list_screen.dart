import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/home/home_bloc.dart';
import 'package:nymble_assignment/bloc/player/player_bloc.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';
import 'package:nymble_assignment/presentation/list_tile.dart';
import 'package:nymble_assignment/presentation/music_details_screen.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

class MusicListScreen extends StatefulWidget {
  const MusicListScreen({super.key});

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  late HomeBloc homeBloc;
  late PlayerBloc playerBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    playerBloc = BlocProvider.of<PlayerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is HomeSuccess) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  MusicModel musicModel = state.musicList[index];
                  return ListTileWidget(
                    musicModel: musicModel,
                    onTap: () {
                      homeBloc.add(ListItemPress(selectedModel: musicModel));
                      // playerBloc.add(PlayerStartOrResume(
                      //     url: homeBloc.state.musicList[index].url,
                      //     index: index));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MusicDetailsScreen(musicModel: musicModel)));
                    },
                    onHeartTap: () {
                      homeBloc.add(ListItemLikePress(
                          index: index,
                          isLiked: musicModel.isLiked,
                          url: musicModel.url));
                    },
                  );
                },
                itemCount: state.musicList.length,
              )),
              if (state.selectedModel != null)
                BlocBuilder<PlayerBloc, MyPlayerState>(
                  builder: (context, mState) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                      decoration: BoxDecoration(
                        color: AppColors.darkThemePrimaryDark,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(color: Color(0x55212121), blurRadius: 8.0),
                        ],
                      ),
                      child: Column(children: [
                        // Slider.adaptive(
                        //     value: position.inSeconds.toDouble(),
                        //     min: 0.0,
                        //     max: duration.inSeconds.toDouble(),
                        //     onChanged: (_) {}),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: CachedNetworkImage(
                                        height: 400,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder: (context, url,
                                                progress) =>
                                            Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                        imageUrl:
                                            state.selectedModel!.coverUrl)),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.selectedModel!.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500, fontSize: 14.0)),
                                      const SizedBox(height: 2.0),
                                      Text(state.selectedModel!.artist,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0))
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (mState.isPlaying) {
                                        if (homeBloc.state.selectedModel !=
                                            null) {
                                          playerBloc.add(PlayerOnPaused(
                                              selectedModel: homeBloc
                                                  .state.selectedModel!));
                                        }
                                      } else {
                                        if (homeBloc.state.selectedModel !=
                                            null) {
                                          playerBloc.add(PlayerStartOrResume(
                                              url: homeBloc
                                                  .state.selectedModel!.url,
                                              selectedModel: homeBloc
                                                  .state.selectedModel!));
                                        }
                                      }
                                    },
                                    iconSize: 40.0,
                                    icon: mState.isPlaying
                                        ? const Icon(Icons.pause_rounded)
                                        : const Icon(Icons.play_arrow))
                              ]),
                        )
                      ]),
                    );
                  },
                )
            ],
          );
        }
        return const Center(
          child: Text("Something went wrong"),
        );
      },
    );
  }
}

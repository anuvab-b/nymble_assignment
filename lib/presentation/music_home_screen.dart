import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_assignment/bloc/home/home_bloc.dart';
import 'package:nymble_assignment/bloc/player/player_bloc.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';
import 'package:nymble_assignment/presentation/list_tile.dart';
import 'package:nymble_assignment/presentation/music_details_screen.dart';

class MusicHomeScreen extends StatefulWidget {
  const MusicHomeScreen({super.key});

  @override
  State<MusicHomeScreen> createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen> {
  late HomeBloc homeBloc;
  late PlayerBloc playerBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    playerBloc = BlocProvider.of<PlayerBloc>(context);
    homeBloc.add(OnHomeInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              const Text("My Playlist", style: TextStyle(color: Colors.black)),
          elevation: 0,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
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
                    itemBuilder: (ctx, index) {
                      MusicModel musicModel = state.musicList[index];
                      return ListTileWidget(
                        musicModel: musicModel,
                        onTap: () {
                          // homeBloc.add(ListItemPress(itemIndex: index));
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
                  if (state.selectedIndex != null && state.selectedIndex!=-1)
                    BlocBuilder<PlayerBloc, MyPlayerState>(
                      builder: (context, mState) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x55212121), blurRadius: 8.0),
                            ],
                          ),
                          child: Column(children: [
                            // Slider.adaptive(
                            //     value: position.inSeconds.toDouble(),
                            //     min: 0.0,
                            //     max: duration.inSeconds.toDouble(),
                            //     onChanged: (_) {}),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                              image: NetworkImage(state
                                                  .musicList[
                                                      state.selectedIndex!]
                                                  .coverUrl),
                                              fit: BoxFit.fill)),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              state
                                                  .musicList[
                                                      state.selectedIndex!]
                                                  .title,
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600)),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            state
                                                .musicList[state.selectedIndex!]
                                                .artist,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          if (mState.isPlaying) {
                                            if (homeBloc.state.selectedIndex !=
                                                null) {
                                              playerBloc.add(PlayerOnPaused(
                                                  index: homeBloc
                                                      .state.selectedIndex!));
                                            }
                                          } else {
                                            if (homeBloc.state.selectedIndex !=
                                                null) {
                                              playerBloc.add(
                                                  PlayerStartOrResume(
                                                      url: homeBloc
                                                          .state
                                                          .musicList[state
                                                              .selectedIndex!]
                                                          .url,
                                                      index: homeBloc.state
                                                          .selectedIndex!));
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
        ));
  }
}

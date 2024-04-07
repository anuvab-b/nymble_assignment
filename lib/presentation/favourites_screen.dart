import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nymble_assignment/bloc/home/home_bloc.dart';
import 'package:nymble_assignment/bloc/player/player_bloc.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';
import 'package:nymble_assignment/presentation/list_tile.dart';
import 'package:nymble_assignment/presentation/music_details_screen.dart';
import 'package:nymble_assignment/presentation/widgets/text.dart';
import 'package:nymble_assignment/utils/constants.dart';
import 'package:nymble_assignment/utils/theme_styles.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
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
                  child: state.favouritesList.isNotEmpty
                      ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            MusicModel musicModel = state.favouritesList[index];
                            return ListTileWidget(
                              isLiked: true,
                              musicModel: musicModel,
                              onTap: () {
                                // homeBloc.add(ListItemPress(itemIndex: index));
                                // playerBloc.add(PlayerStartOrResume(
                                //     url: homeBloc.state.favouritesList[index].url,
                                //     index: index));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MusicDetailsScreen(
                                        musicModel: musicModel)));
                              },
                              onHeartTap: () {
                                homeBloc.add(FavouriteItemPress(
                                    index: index, url: musicModel.url));
                              },
                            );
                          },
                          itemCount: state.favouritesList.length,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppConstants.icNoData,
                                  height: 240, width: 240),
                              const SizedBox(height: 16.0),
                              const CommonText(
                                  value: "Add Favourites",
                                  textColor: kTitleTextDarkColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28),
                              const SizedBox(height: 16.0),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CommonText(
                                    value: "Don't forget to bookmark the songs you like the most so that you can easily find those here",
                                    textColor: kBodyTextColorDark,
                                    fontWeight: FontWeight.w400,
                                    maxLines: 3,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
              if (state.selectedIndex != null && state.selectedIndex != -1)
                BlocBuilder<PlayerBloc, MyPlayerState>(
                  builder: (context, mState) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Color(0x55212121), blurRadius: 8.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          image: NetworkImage(state
                                              .favouritesList[
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
                                              .favouritesList[
                                                  state.selectedIndex!]
                                              .title,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 6.0),
                                      Text(
                                        state
                                            .favouritesList[
                                                state.selectedIndex!]
                                            .artist,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14.0),
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
                                          playerBloc.add(PlayerStartOrResume(
                                              url: homeBloc
                                                  .state
                                                  .favouritesList[
                                                      state.selectedIndex!]
                                                  .url,
                                              index: homeBloc
                                                  .state.selectedIndex!));
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

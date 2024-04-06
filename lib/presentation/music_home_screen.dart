import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nymble_assignment/domain/i_music_repository.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';
import 'package:nymble_assignment/presentation/list_tile.dart';
import 'package:nymble_assignment/presentation/music_details_screen.dart';
import 'package:nymble_assignment/service_locator.dart';
class MusicHomeScreen extends StatefulWidget {
  const MusicHomeScreen({super.key});

  @override
  State<MusicHomeScreen> createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen> {
  List<MusicModel> musicList = List.empty(growable: true);
  MusicModel? selectedMusicModel;
  bool isLoading = false;
  IconData playerIcon = Icons.play_arrow;
  Duration duration = const Duration();
  Duration position = const Duration();

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void playMusic(int index) async {
    if (isPlaying && selectedMusicModel!.coverUrl != musicList[index].url) {
      audioPlayer.pause();
      await audioPlayer.play(UrlSource(musicList[index].url),
          mode: PlayerMode.mediaPlayer);
      setState(() {
        selectedMusicModel = musicList[index];
        playerIcon = Icons.pause_rounded;
      });
    } else if (!isPlaying) {
      await audioPlayer.play(UrlSource(musicList[index].url));
      setState(() {
        isPlaying = true;
        playerIcon = Icons.pause_rounded;
      });
    }

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMusic();
  }

  fetchMusic() async {
    setState(() {
      isLoading = true;
    });
    IMusicRepository musicRepository = getIt.get<IMusicRepository>();
    musicList = await musicRepository.getMusicList();
    setState(() {
      isLoading = false;
    });
  }

  setSelectedMusicModel(int index) {
    setState(() {
      selectedMusicModel = musicList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Playlist", style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: isLoading
                  ? const Center(child: CupertinoActivityIndicator())
                  : ListView.builder(
                itemBuilder: (ctx, index) {
                  MusicModel musicModel = musicList[index];
                  return ListTileWidget(
                      title: musicModel.title,
                      artist: musicModel.artist,
                      cover: musicModel.coverUrl,
                      onTap: () {
                        playMusic(index);
                        setSelectedMusicModel(index);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MusicDetailsScreen(
                                musicModel: musicModel)));
                      });
                },
                itemCount: musicList.length,
              )),
          if (selectedMusicModel != null)
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0x55212121), blurRadius: 8.0),
                ],
              ),
              child: Column(children: [
                Slider.adaptive(
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (_) {}),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      selectedMusicModel!.coverUrl),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(selectedMusicModel!.title,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6.0),
                              Text(
                                selectedMusicModel!.artist,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                audioPlayer.pause();
                                setState(() {
                                  isPlaying = false;
                                  playerIcon = Icons.play_arrow_rounded;
                                });
                              } else {
                                audioPlayer.resume();
                                setState(() {
                                  playerIcon = Icons.pause;
                                  isPlaying = true;
                                });
                              }
                            },
                            iconSize: 40.0,
                            icon: Icon(playerIcon))
                      ]),
                )
              ]),
            )
        ],
      ),
    );
  }
}

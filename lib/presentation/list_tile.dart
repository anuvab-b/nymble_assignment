import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

class ListTileWidget extends StatelessWidget {
  final MusicModel musicModel;
  final VoidCallback onTap;
  final VoidCallback onHeartTap;

  const ListTileWidget(
      {super.key,
      required this.onTap,
      required this.onHeartTap,
      required this.musicModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Hero(
                    tag: musicModel.url,
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: NetworkImage(musicModel.coverUrl),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(musicModel.title,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6.0),
                      Text(
                        musicModel.artist,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            IconButton(
                onPressed: onHeartTap,
                icon: Icon(
                    !musicModel.isLiked ? MdiIcons.heartOutline : MdiIcons.heart,
                    color: Colors.red))
          ],
        ),
      ),
    );
  }
}

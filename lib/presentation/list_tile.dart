import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nymble_assignment/domain/music_list_model.dart';

class ListTileWidget extends StatelessWidget {
  final MusicModel musicModel;
  final VoidCallback onTap;
  final VoidCallback onHeartTap;
  final bool isLiked;

  const ListTileWidget(
      {super.key,
      this.isLiked = false,
      required this.onTap,
      required this.onHeartTap,
      required this.musicModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).colorScheme.background,
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
                      height: 64.0,
                      width: 64.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                              image: NetworkImage(musicModel.coverUrl),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(musicModel.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16.0)),
                        const SizedBox(height: 6.0),
                        Text(musicModel.artist,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            IconButton(
                onPressed: onHeartTap,
                icon: Icon(
                    isLiked
                        ? MdiIcons.heart
                        : !musicModel.isLiked
                            ? MdiIcons.heartOutline
                            : MdiIcons.heart,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF6F0000)
                        : Colors.red))
          ],
        ),
      ),
    );
  }
}

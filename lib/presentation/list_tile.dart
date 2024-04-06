import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String artist;
  final String cover;
  final VoidCallback onTap;

  const ListTileWidget(
      {super.key,
      required this.title,
      required this.artist,
      required this.cover,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(image: NetworkImage(cover),fit: BoxFit.fill)),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6.0),
                Text(
                  artist,
                  style: const TextStyle(color: Colors.grey, fontSize: 16.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vibean/Helper/song.dart';

class SongCard2 extends StatefulWidget {
  final Song song;
  final VoidCallback playSong;
  const SongCard2({Key? key, required this.song, required this.playSong})
      : super(key: key);

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: 340,
      height: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.network(widget.song.image, width: 60, height: 60),
          ),
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(widget.song.title + " - " + widget.song.duration,
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(widget.song.author,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: widget.playSong,
              icon: const Icon(Icons.play_arrow),
              color: Colors.white,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

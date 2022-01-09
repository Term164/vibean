import 'package:flutter/material.dart';
import 'package:vibean/Helper/song.dart';

class SongCard extends StatefulWidget {
  final Song song;
  const SongCard({Key? key, required this.song}) : super(key: key);

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7941D),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.all(10),
      width: 330,
      height: 120,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.network(
              widget.song.image,
              width: 90,
              height: 90,
            ),
          ),
          Expanded(
            flex: 4,
            child: ListTile(
              title: Text(widget.song.title + " - " + widget.song.duration),
              subtitle: Text(widget.song.author),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.download),
              alignment: Alignment.centerLeft,
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

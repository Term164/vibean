import 'package:flutter/material.dart';
import 'package:vibean/Helper/song.dart';
import 'package:open_file/open_file.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  late List<Song> songs;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    songs = data['songs'];

    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Downloads"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.separated(
              itemBuilder: (context, index) {
                Song song = songs[index];
                return songCard(song);
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 2, color: Color(0xFFF7941D));
              },
              itemCount: songs.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget songCard(Song song) {
    String displayName = song.title;
    String duration = song.duration;
    String artist = song.author;
    return Container(
      color: Colors.blue[900],
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Icon(
              Icons.music_video_rounded,
              size: 60,
              color: Colors.orange,
            ),
          ),
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(displayName + " - " + duration,
                  style: const TextStyle(color: Colors.white)),
              subtitle:
                  Text(artist, style: const TextStyle(color: Colors.white)),
            ),
          ),
          IconButton(
            onPressed: () {
              OpenFile.open(song.uri);
            },
            icon: const Icon(
              Icons.folder,
              size: 30,
              color: Color(0xffffe9a2),
            ),
          ),
        ],
      ),
    );
  }
}

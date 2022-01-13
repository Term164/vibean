import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();

class MusicLibrary extends StatefulWidget {
  const MusicLibrary({Key? key}) : super(key: key);

  @override
  _MusicLibraryState createState() => _MusicLibraryState();
}

class _MusicLibraryState extends State<MusicLibrary> {
  var songIndex;
  late List<SongInfo> songs;
  final assetsAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    songs = data['songs'];

    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Music Library"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.separated(
              itemBuilder: (context, index) {
                SongInfo song = songs[index];
                return songCard(song, index);
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 2, color: Color(0xFFF7941D));
              },
              itemCount: songs.length,
            ),
          ),
          Container(
            height: 180,
            color: const Color(0xFFF7941D),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.music_video,
                      size: 90,
                    ),
                    IconButton(
                        onPressed: () {
                          prev();
                        },
                        icon:
                            const Icon(Icons.skip_previous_outlined, size: 40)),
                    IconButton(
                        onPressed: () {
                          playPause();
                        },
                        icon: const Icon(Icons.play_arrow_outlined, size: 40)),
                    IconButton(
                        onPressed: () {
                          next();
                        },
                        icon: const Icon(Icons.skip_next_outlined, size: 40))
                  ],
                ),
                Expanded(
                  child: ListTile(
                    title: songIndex != null
                        ? Text(songs[songIndex].title)
                        : Text("N/A"),
                    subtitle: songIndex != null
                        ? Text(songs[songIndex].artist)
                        : Text("N/A"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void playPause() {
    assetsAudioPlayer.playOrPause();
  }

  void next() {
    assetsAudioPlayer.pause();
    if (songIndex + 1 < songs.length) {
      assetsAudioPlayer.open(
        Audio.file(songs[++songIndex].uri),
      );
      assetsAudioPlayer.play();
    }
  }

  void prev() {
    assetsAudioPlayer.pause();
    if (songIndex > 0) {
      assetsAudioPlayer.open(
        Audio.file(songs[--songIndex].uri),
      );
      assetsAudioPlayer.play();
    }
  }

  void playSong(uri) async {
    await assetsAudioPlayer.pause();
    await assetsAudioPlayer.open(Audio.file(uri));
    assetsAudioPlayer.play();
  }

  Widget songCard(SongInfo song, index) {
    String displayName = song.displayName ?? "N/A";
    String duration = song.duration ?? "N/A";
    String artist = song.artist ?? "N/A";
    return Container(
      color: Colors.blue[900],
      child: Row(
        children: [
          if (song.albumArtwork == null)
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(Icons.music_video, size: 60),
            ),
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(
                  displayName +
                      " - " +
                      (duration != "N/A"
                          ? format(Duration(milliseconds: int.parse(duration)))
                          : duration),
                  style: const TextStyle(color: Colors.white)),
              subtitle:
                  Text(artist, style: const TextStyle(color: Colors.white)),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                playSong(song.uri);
                setState(() {
                  songIndex = index;
                });
              },
              icon: const Icon(Icons.play_arrow),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}

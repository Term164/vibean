import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localstore/localstore.dart';
import 'package:vibean/Helper/song.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();

class Loading extends StatefulWidget {
  static int mode = 0;
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> getSongs() async {
    if (Loading.mode == 0) {
      List<SongInfo> songs = await audioQuery.getSongs();
      Navigator.pushReplacementNamed(context, "/library", arguments: {
        'songs': songs,
      });
    } else {
      final db = Localstore.instance;
      final items = await db.collection('songs').get();
      List<Song> songs = [];

      items?.forEach((key, value) {
        songs.add(Song(value['author'], value['title'], value['duration'],
            value['image'], value['uri']));
      });

      Navigator.pushReplacementNamed(context, "/downloads", arguments: {
        'songs': songs,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: const Center(
        child: SpinKitWave(
          color: Color(0xFFF7941D),
          size: 50.0,
        ),
      ),
    );
  }
}

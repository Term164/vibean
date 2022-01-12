import 'package:flutter/material.dart';
import 'package:googleapis/servicemanagement/v1.dart';
import 'package:localstore/localstore.dart';
import 'package:vibean/Addons/song_card.dart';
import 'package:vibean/Addons/song_card_2.dart';
import 'package:vibean/Helper/song.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:vibean/pages/loading.dart';

final _googleSignIn =
    GoogleSignIn(scopes: <String>[YouTubeApi.youtubeReadonlyScope]);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  GoogleSignInAccount? _currentUser;
  bool _play = false;

  final db = Localstore.instance;

  String currentTitle = "Not playing";
  String currentAuthor = "N/A";
  String pictureURI =
      "https://cdn4.iconfinder.com/data/icons/elega-music-controls/100/Album-512.png";

  late List<Song> songs;

  void updateSongsList() async {
    final items = await db.collection('songs').get();
    setState(() {
      for (var i = 0; i < songs.length; i++) {
        if (i >= items!.length) return;
        var song = items.values.elementAt(i);
        if (song != null) {
          songs[i] = Song(song['author'], song['title'], song['duration'],
              song['image'], song['uri']);
        }
      }
    });
  }

  void playRandomSong() {}

  void playDownloadedSong(Song song) {
    setState(() {
      currentTitle = song.title;
      currentAuthor = song.author;
      pictureURI = song.image;
      playSong(song.uri);
    });
  }

  void playPause(context) {
    if (currentTitle == "Not playing") {
      final snackBar = SnackBar(
          content: const Text('No song selected'),
          action: SnackBarAction(label: 'Hide', onPressed: () {}));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      assetsAudioPlayer.playOrPause();
    }
  }

  void next(context) {
    if (currentTitle == "Not playing") {
      final snackBar = SnackBar(
          content: const Text('No song selected'),
          action: SnackBarAction(label: 'Hide', onPressed: () {}));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      assetsAudioPlayer.pause();
      assetsAudioPlayer.next();
    }
  }

  void prev(context) {
    if (currentTitle == "Not playing") {
      final snackBar = SnackBar(
          content: const Text('No song selected'),
          action: SnackBarAction(label: 'Hide', onPressed: () {}));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      assetsAudioPlayer.pause();
      assetsAudioPlayer.previous();
    }
  }

  playSong(uri) {
    assetsAudioPlayer.pause();
    assetsAudioPlayer.open(Audio.file(uri));
    assetsAudioPlayer.play();
  }

  Color mainColor = const Color(0xFFF7941D);

  final Color textColor = Colors.white;
  late YouTubeApi _youtubeApi;

  Widget createNavBar(GoogleSignInAccount? user, context) {
    return Drawer(
      backgroundColor: Color(0xFFF7941D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user!.displayName ?? ''),
            accountEmail: Text(user.email),
            currentAccountPicture: GoogleUserCircleAvatar(
              identity: user,
              backgroundColor: Colors.white,
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background.jpg'),
                )),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 40, color: textColor),
            title: Text("Home", style: TextStyle(color: textColor)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.library_music, size: 40, color: textColor),
            title: Text("Music library", style: TextStyle(color: textColor)),
            onTap: () {
              Loading.mode = 0;
              Navigator.pushNamed(context, "/loading");
            },
          ),
          ListTile(
            leading: Icon(Icons.download_rounded, size: 40, color: textColor),
            title: Text("Downloads", style: TextStyle(color: textColor)),
            onTap: () {
              Loading.mode = 1;
              Navigator.pushNamed(context, "/loading");
            },
          ),
          const Divider(height: 20, thickness: 3),
          ListTile(
            leading: Icon(Icons.info_outline, size: 40, color: textColor),
            title: Text("About us", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          ListTile(
            leading:
                Icon(Icons.warning_amber_rounded, size: 40, color: textColor),
            title: Text("Report a bug", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          const Divider(height: 20, thickness: 3),
          ListTile(
            leading: Icon(Icons.exit_to_app, size: 40, color: textColor),
            title: Text("Sign out", style: TextStyle(color: textColor)),
            onTap: () {
              _googleSignIn.disconnect();
              Navigator.pushReplacementNamed(context, "/");
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    _currentUser = data['user'];
    _youtubeApi = data['youtube'];
    songs = data['songs'];
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                size: 30,
              ))
        ],
      ),
      drawer: createNavBar(_currentUser, context),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                "Recently liked",
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: _youtubeApi.playlistItems
                  .list(['snippet', 'contentDetails'], playlistId: 'LL'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List<SongCard>.from(snapshot.data.items
                          .map((song) => SongCard(
                                song: song,
                                update: updateSongsList,
                              ))
                          .toList()),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error_outline,
                      color: Colors.red, size: 60);
                } else {
                  return const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator());
                }
              },
            ),
            Divider(
              height: 30,
              thickness: 2,
              color: mainColor,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
              child: Text(
                "Quick access",
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("Shuffle play", Icon(Icons.shuffle, size: 50), () {}),
                button("Library", Icon(Icons.library_music_outlined, size: 50),
                    () {
                  Loading.mode = 0;
                  Navigator.pushNamed(context, "/loading");
                }),
                button("Recommended",
                    Icon(Icons.local_fire_department_sharp, size: 50), () {}),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text(
                "Added recently",
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SongCard2(
                      song: songs[index],
                      playSong: () {
                        setState(() {
                          Song song = songs[index];
                          currentTitle = song.title;
                          currentAuthor = song.author;
                          pictureURI = song.image;
                          playSong(song.uri);
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 2, color: Color(0xFFF7941D));
                  },
                  itemCount: songs.length),
            ),
            Container(
              color: Color(0xFFF7941D),
              child: Row(
                children: [
                  Image.network(pictureURI, width: 90, height: 90),
                  Expanded(
                    child: ListTile(
                      title: Text(currentTitle),
                      subtitle: Text(currentAuthor),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        prev(context);
                      },
                      icon: Icon(Icons.skip_previous_outlined, size: 40)),
                  IconButton(
                      onPressed: () {
                        playPause(context);
                      },
                      icon: Icon(Icons.play_arrow_outlined, size: 40)),
                  IconButton(
                      onPressed: () {
                        next(context);
                      },
                      icon: Icon(Icons.skip_next_outlined, size: 40))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget button(text, icon, VoidCallback function) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: function,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: icon,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

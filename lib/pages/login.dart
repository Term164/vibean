import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:localstore/localstore.dart';
import 'package:vibean/Helper/song.dart';

final _googleSignIn =
    GoogleSignIn(scopes: <String>[YouTubeApi.youtubeReadonlyScope]);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });

      if (_currentUser != null) {
        _handleYoutube(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleYoutube(GoogleSignInAccount user) async {
    final authClient = await _googleSignIn.authenticatedClient();
    final youtubeApi = YouTubeApi(authClient!);

    List<Song> songs = [];

    final db = Localstore.instance;
    final items = await db.collection('songs').get();
    if (items != null) {
      for (var i = 0; i < 5; i++) {
        if (i >= items.length) {
          songs.add(Song(
              "Empty",
              "Empty",
              "N/A",
              "https://cdn4.iconfinder.com/data/icons/elega-music-controls/100/Album-512.png",
              'null'));
        } else {
          var song = items.values.elementAt(i);
          songs.add(Song(song['author'], song['title'], song['duration'],
              song['image'], song['uri']));
        }
      }
    } else {
      for (var i = 0; i < 5; i++) {
        songs.add(Song(
            "Empty",
            "Empty",
            "N/A",
            "https://cdn4.iconfinder.com/data/icons/elega-music-controls/100/Album-512.png",
            'null'));
      }
    }

    Navigator.pushReplacementNamed(context, "/home", arguments: {
      'user': _currentUser,
      'youtube': youtubeApi,
      'songs': songs,
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Image(image: AssetImage("assets/logo.png")),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              //print(_currentUser);
              _handleSignIn();
            },
            icon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/google.png",
                width: 50,
                height: 50,
              ),
            ),
            label: const Text("Continue with google",
                style: TextStyle(color: Colors.grey, fontSize: 20)),
          )
        ],
      ),
    ));
  }
}

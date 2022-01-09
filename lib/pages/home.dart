import 'package:flutter/material.dart';
import 'package:vibean/Addons/nav_bar.dart';
import 'package:vibean/Addons/song_card.dart';
import 'package:vibean/Addons/song_card_2.dart';
import 'package:vibean/Helper/song.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_manager/audio_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Song> songs = [
    Song("Frank Sinatra", "Fly me to the Moon", "2:29",
        "https://www.lifegate.com/app/uploads/zangaru_11_23102013165204_artworks-000044653866-8qg7am-original.jpg"),
    Song("Don McLean", "American Pie", "8:36",
        "https://www.gottahaverockandroll.com/ItemImages/000013/mar14-345_lg.jpeg"),
    Song("Toploader", "Dancing in the Moonlight", "3:46",
        "https://i.pinimg.com/originals/b9/b3/c2/b9b3c2a9046690772ca4d9958deeddfc.jpg")
  ];

  Color mainColor = const Color(0xFFF7941D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 30,
              ))
        ],
      ),
      drawer: NavBar(),
      body: Container(
        padding: EdgeInsets.all(10),
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
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: songs.map((song) => SongCard(song: song)).toList(),
                ),
              ),
            ),
            Divider(height: 30, thickness: 2, color: mainColor),
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
                button("Shuffle play", Icon(Icons.shuffle, size: 50)),
                button("Library", Icon(Icons.library_music_outlined, size: 50)),
                button("Recommended",
                    Icon(Icons.local_fire_department_sharp, size: 50)),
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
                    return SongCard2(song: songs[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 2,
                      color: Color(0xFFF7941D),
                    );
                  },
                  itemCount: songs.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(text, icon) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {},
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

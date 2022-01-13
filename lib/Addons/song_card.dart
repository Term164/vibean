import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:googleapis/youtube/v3.dart' hide Video;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:localstore/localstore.dart';

class SongCard extends StatefulWidget {
  final Function(dynamic) update;
  final PlaylistItem song;
  const SongCard({Key? key, required this.song, required this.update})
      : super(key: key);

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF7941D),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: const EdgeInsets.all(10),
      width: 330,
      height: 120,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.network(
                widget.song.snippet!.thumbnails!.default_!.url.toString(),
                width: 90,
                height: 90),
          ),
          Expanded(
            flex: 4,
            child: ListTile(
              title: Text(widget.song.snippet!.title.toString()),
              subtitle:
                  Text(widget.song.snippet!.videoOwnerChannelTitle.toString()),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () async {
                var yt = YoutubeExplode();
                Video video = await yt.videos.get(
                    "https://www.youtube.com/watch?v=${widget.song.contentDetails!.videoId.toString()}");
                StreamManifest manifest = await yt.videos.streamsClient
                    .getManifest(
                        widget.song.contentDetails!.videoId.toString());
                var streamInfo = manifest.audioOnly.withHighestBitrate();

                if (streamInfo != null) {
                  await Permission.storage.request();
                  var status = await Permission.storage.status;
                  if (status.isDenied) {
                    return;
                  }

                  if (status.isGranted) {
                    var stream = yt.videos.streamsClient.get(streamInfo);

                    var path =
                        await ExtStorage.getExternalStoragePublicDirectory(
                            ExtStorage.DIRECTORY_DOWNLOADS);

                    File file = await File(path + "/${video.title}.mp4")
                        .create(recursive: true);

                    var fileStream = file.openWrite();

                    await stream.pipe(fileStream);

                    await fileStream.flush();
                    await fileStream.close();

                    final snackBar = SnackBar(
                        content: const Text('Download finished'),
                        action:
                            SnackBarAction(label: 'Hide', onPressed: () {}));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
                    await _flutterFFmpeg
                        .execute(
                            '-i "${path}/${video.title}.mp4" -vn "${path}/${video.title}.mp3"')
                        .then(
                            (rc) => print("FFmpeg process exited with rc $rc"));

                    await File(path + "/${video.title}.mp4").delete();

                    final db = Localstore.instance;
                    final id = db.collection('songs').doc().id;

                    db.collection('songs').doc(id).set({
                      'title': '${widget.song.snippet!.title}',
                      'uri': '${path}/${video.title}.mp3',
                      'image':
                          '${widget.song.snippet!.thumbnails!.default_?.url}',
                      'author':
                          '${widget.song.snippet!.videoOwnerChannelTitle}',
                      'duration': '${video.duration}'.split('.')[0],
                    });

                    // final items = await db.collection('songs').get();
                    // if (items != null) {
                    //   for (var item in items.keys) {
                    //     db
                    //         .collection('songs')
                    //         .doc(item.toString().split("/")[2])
                    //         .delete();
                    //   }
                    // }

                    // final test = await db.collection('songs').get();
                    // print(test);

                    final secondSnackBar = SnackBar(
                        content: const Text('Conversion finshed'),
                        action:
                            SnackBarAction(label: 'Hide', onPressed: () {}));

                    ScaffoldMessenger.of(context).showSnackBar(secondSnackBar);
                    widget.update(await db.collection('songs').doc(id).get());
                  }
                }

                yt.close();
              },
              icon: const Icon(Icons.download),
              alignment: Alignment.centerLeft,
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

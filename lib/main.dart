// @dart=2.9
import 'package:flutter/material.dart';
import 'package:vibean/pages/downloads.dart';
import 'package:vibean/pages/library.dart';
import 'package:vibean/pages/home.dart';
import 'package:vibean/pages/loading.dart';
import 'package:vibean/pages/login.dart';
import 'package:localstore/localstore.dart';
import 'package:flutter/services.dart';
import 'package:vibean/pages/report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/downloads': (context) => Downloads(),
      '/library': (context) => MusicLibrary(),
      '/contactus': (context) => Contact(),
    },
  ));
}

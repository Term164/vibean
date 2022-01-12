// @dart=2.9
import 'package:flutter/material.dart';
import 'package:vibean/pages/downloads.dart';
import 'package:vibean/pages/library.dart';
import 'package:vibean/pages/home.dart';
import 'package:vibean/pages/loading.dart';
import 'package:vibean/pages/login.dart';
import 'package:localstore/localstore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/downloads': (context) => Downloads(),
      '/library': (context) => MusicLibrary(),
    },
  ));
}

// @dart=2.9
import 'package:flutter/material.dart';
import 'package:vibean/pages/choose_location.dart';
import 'package:vibean/pages/home.dart';
import 'package:vibean/pages/loading.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      },
    ));

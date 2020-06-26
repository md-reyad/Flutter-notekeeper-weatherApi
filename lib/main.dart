import 'package:flutter/material.dart';
import 'package:flutternote/screens/NoteDetails.dart';
import 'package:flutternote/screens/home.dart';
import 'package:flutternote/screens/noteList.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData.dark(),
//      ThemeData(
//          primarySwatch: Colors.deepPurple
//      ),
      home: Home(),
    );
  }
}
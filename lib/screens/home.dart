import 'package:flutter/material.dart';
import 'package:flutternote/screens/Calculator.dart';
import 'package:flutternote/screens/Weather.dart';
import 'package:flutternote/screens/noteList.dart';
import 'package:flutternote/screens/placeholder_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    NoteList(),
//    PlaceholderWidget(Colors.black45),
    Calculator(),
    Weather(Colors.green),
    PlaceholderWidget(Colors.blue)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('My Flutter App'),
//      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calculator),
            title: Text('Calculator'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.water),
            title: Text('Weather'),
          ),

//          new BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              title: Text('Profile')
//          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
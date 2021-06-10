import 'package:crop_yield_predictor/predictor_fragment.dart';
import 'package:crop_yield_predictor/profile_fragment.dart';
import 'package:crop_yield_predictor/settings_fragment.dart';
import 'package:flutter/material.dart';
import 'PlaceholderWidget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Predictor(),
    Profile(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF95E289),
        onTap: onTabTapped,
        iconSize: 30,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.green,
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Colors.green,
            title: Text(''),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: Colors.green,
              title: Text('')
          )
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
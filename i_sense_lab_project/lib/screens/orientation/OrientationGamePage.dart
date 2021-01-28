import 'package:flutter/material.dart';

class OrientationGameScreen extends StatefulWidget {
  @override
  _OrientationGameScreenState createState() => _OrientationGameScreenState();
}

class _OrientationGameScreenState extends State<OrientationGameScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    dynamic pic = (() {
      switch (args) {
        case 1:
          return Image.asset("images/orientation/season_spring.png");
        case 2:
          return Image.asset("images/orientation/season_summer.png");
        case 3:
          return Image.asset("images/orientation/season_autumn.png");
        case 4:
          return Image.asset("images/orientation/season_winter.png");
      }
    }());
    return Scaffold(
      body: Container(
        child: Column(
          children: [pic],
        ),
      ),
    );
  }
}

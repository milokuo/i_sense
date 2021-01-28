import 'package:flutter/material.dart';
import '../../componenets/GameIcon.dart';

class OrientationSettingScreen extends StatefulWidget {
  @override
  _OrientationSettingScreenState createState() => _OrientationSettingScreenState();
}

class _OrientationSettingScreenState extends State<OrientationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: screenWidth * 0.05,
            mainAxisSpacing: screenHeight * 0.02,
            children: [
              GameIcon(
                title: "春",
                onPressed: () {
                  Navigator.pushNamed(context, "OrientationGamePage",
                      arguments: 1);
                },
                imagePath: "images/orientation/season_spring_icon.png",
              ),
              GameIcon(
                title: "夏",
                onPressed: () {
                  Navigator.pushNamed(context, "OrientationGamePage",
                      arguments: 2);
                },
                imagePath: "images/orientation/season_summer_icon.png",
              ),
              GameIcon(
                title: "秋",
                onPressed: () {
                  Navigator.pushNamed(context, "OrientationGamePage",
                      arguments: 3);
                },
                imagePath: "images/orientation/season_autumn_icon.png",
              ),
              GameIcon(
                title: "冬",
                onPressed: () {
                  Navigator.pushNamed(context, "OrientationGamePage",
                      arguments: 4);
                },
                imagePath: "images/orientation/season_winter_icon.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

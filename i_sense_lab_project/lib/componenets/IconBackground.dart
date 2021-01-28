import 'package:flutter/material.dart';

class IconBackground extends StatefulWidget {
  @override
  _IconBackgroundState createState() => _IconBackgroundState();
}

class _IconBackgroundState extends State<IconBackground> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 10), () {
      setState(() {
        _loading = true;
      });
      print("start loading");
    });
    return AnimatedOpacity(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          image: DecorationImage(
            image: AssetImage('images/hands_background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      opacity: _loading ? 1.0 : 0.0,
      duration: Duration(milliseconds: 3000),
    );
  }
}

import 'package:flutter/material.dart';

class GameIcon extends StatelessWidget {
  GameIcon({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.imagePath = "images/undefined.png",
  }) : super(key: key);
  final String title;
  final String imagePath;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
                flex: 23),
            Spacer(flex: 1),
            Divider(
              thickness: 3,
              color: Colors.black54,
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
        // child: Column(
        //   children: [
        //     SizedBox(
        //       height: parentHeight * 0.05,
        //     ),
        //     SizedBox(
        //       child: Image.asset(imagePath),
        //       height: parentHeight * 0.65,
        //     ),
        //     SizedBox(
        //       height: parentHeight * 0.05,
        //     ),
        //     Divider(
        //       height: parentHeight * 0.03,
        //       thickness: 3,
        //       color: Colors.black54,
        //     ),
        //     Text(
        //       title,
        //       style: TextStyle(
        //         fontSize: 20,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

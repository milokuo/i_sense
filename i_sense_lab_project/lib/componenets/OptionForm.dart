import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_sense_lab_project/screens/login/login_screen.dart';

class OptionsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: HomePageOptionsBar(),
      ),
    );
  }
}

class HomePageOptionsBar extends StatelessWidget {
  const HomePageOptionsBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomePageButtonLayout(
          button: RaisedButton(
            child: Center(
              child: Text(
                "開始訓練",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(0xe9, 0xda, 0xbb, 1.0),
                ),
              ),
            ),
            color: Color.fromRGBO(0x49, 0x3f, 0x3d, 0.8),
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "GameSelectionScreen");
            },
          ),
        ),
        HomePageButtonLayout(
          button: RaisedButton(
            child: Center(
              child: Text(
                "設定",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            color: Colors.greenAccent,
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {},
          ),
        ),
        HomePageButtonLayout(
          button: RaisedButton(
            child: Center(
              child: Text(
                "登出",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(0xe9, 0xda, 0xbb, 1.0),
                ),
              ),
            ),
            color: Color.fromRGBO(0x49, 0x3f, 0x3d, 0.8),
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
        ),
        HomePageButtonLayout(
          button: RaisedButton(
            child: Center(
              child: Text(
                "結束遊戲",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.redAccent,
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ),
      ],
    );
  }
}

class HomePageButtonLayout extends StatelessWidget {
  const HomePageButtonLayout({
    Key key,
    @required this.button,
  }) : super(key: key);

  final dynamic button;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Expanded(
          flex: 8,
          child: SizedBox(
            height: 65,
            child: button,
          ),
        ),
        Spacer(),
      ],
    );
  }
}

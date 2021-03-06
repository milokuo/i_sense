import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:i_sense_lab_project/constants.dart';
import 'package:i_sense_lab_project/screens/bluetooth/bluetooth_setting_screen.dart';
import 'package:i_sense_lab_project/variables.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.2,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.2 - 27,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kCurThemeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      child: SizedBox(
                        width: size.width * 0.6,
                        height: size.height * 0.2,
                        child: Align(
                          alignment: Alignment(0, -0.8),
                          child: TypewriterAnimatedTextKit(
                            text: [
                              "\n  早安 世界！",
                              "\n忘掉過去 珍惜現在\n  享受今天 樂觀未來",
                              "\n笑一笑 十年少\n  笑口常開 健康常在"
                            ],
                            textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            speed: Duration(milliseconds: 300),
                            pause: Duration(seconds: 5),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Image.asset('images/main_pics/cheer4.png',
                        width: size.width * 0.35),
                  ],
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          child: Text("我的NAXEN"),
          onPressed: () async {
            if (flutterBlue == null || !await flutterBlue.isAvailable) {
              BotToast.showSimpleNotification(title: "裝置不支援藍芽設備，無法利用NAXEN功能");
              return;
            }
            if (!await flutterBlue.isOn) {
              BotToast.showSimpleNotification(
                  title: "開啟失敗", subTitle: "必須先啟動藍芽功能，才能利用NAXEN設備");
              return;
            }
            Navigator.pushNamed(context, "BluetootheSettingScreen");
          },
        ),
      ],
    );
  }
}

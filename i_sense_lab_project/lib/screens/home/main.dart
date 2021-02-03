import 'package:flutter/material.dart';
import 'package:i_sense_lab_project/constants.dart';
import 'package:i_sense_lab_project/variables.dart';

//components
import '../../componenets/IconBackground.dart';
import '../../componenets/OptionForm.dart';

//pages
import '../../screens/orientation/OrientationSettingPage.dart';
import '../game_select/GameSelectionPage.dart';
import '../compute/ComputeGamePage.dart';
import '../../screens/orientation/OrientationGamePage.dart';
import '../../screens/memorization/MemorizationGameScreen.dart';
import 'package:i_sense_lab_project/screens/login/login_screen.dart';
import 'package:i_sense_lab_project/screens/bluetooth/bluetooth_setting_screen.dart';
import 'components/body.dart';

//packages
import 'package:bot_toast/bot_toast.dart';

void main() => runApp(EasyHappyLifeApp());

class EasyHappyLifeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "健康樂生活",
      routes: {
        "/": (context) => HomePage(),
        "GameSelectionScreen": (context) => GameSelectionScreen(),
        "ComputeGameScreen": (context) => ComputeGameScreen(),
        "OrientationSettingScreen": (context) => OrientationSettingScreen(),
        "OrientationGameScreen": (context) => OrientationGameScreen(),
        "MemorizationGameScreen": (context) => MemorizationGameScreen(),
        "BluetootheSettingScreen": (context) => BluetootheSettingScreen(),
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kCurThemeColor,
        elevation: 0,
        leading: IconTheme(
          data: IconThemeData(color: Colors.white70),
          child: IconButton(
            icon: Icon(Icons.navigate_before, size: 30),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Body(),
      ),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: 0,
      //       left: 0,
      //       height: MediaQuery.of(context).size.height * 0.5,
      //       width: MediaQuery.of(context).size.width * 1.0,
      //       child: IconBackground(),
      //     ),
      //     Positioned(
      //       top: MediaQuery.of(context).size.height * 0.4,
      //       left: MediaQuery.of(context).size.width * 0.07,
      //       height: MediaQuery.of(context).size.height * 0.55,
      //       width: MediaQuery.of(context).size.width * 0.86,
      //       child: OptionsForm(),
      //     ),
      //   ],
      // ),
    );
  }

  AppBar buildAppBar() {}
}

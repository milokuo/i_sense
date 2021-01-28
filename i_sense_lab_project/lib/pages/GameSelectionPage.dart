import 'package:flutter/material.dart';
import '../componenets/GameIcon.dart';

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "選擇一項訓練",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              ItemsSelectionGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemsSelectionGridView extends StatelessWidget {
  const ItemsSelectionGridView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Flexible(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          physics: NeverScrollableScrollPhysics(),
          children: [
            GameIcon(
              title: "計算",
              onPressed: () {
                Navigator.pushNamed(context, "ComputeGameScreen");
              },
              imagePath: "images/compute_icon.png",
            ),
            GameIcon(
              title: "定向",
              onPressed: () {
                Navigator.pushNamed(context, "OrientationSettingScreen");
              },
              imagePath: "images/orientation_icon.png",
            ),
            GameIcon(
              title: "記憶",
              onPressed: () {
                Navigator.pushNamed(context, "MemorizationGameScreen");
              },
              imagePath: "images/memorization_icon.png",
            ),
            GameIcon(
              title: "依樣畫葫蘆",
              onPressed: () {
                Navigator.pushNamed(context, "OrientationSettingScreen");
              },
              imagePath: "images/drawing_icon.png",
            ),
            GameIcon(
              title: "命名",
              onPressed: () {
                Navigator.pushNamed(context, "OrientationSettingScreen");
              },
              imagePath: "images/naming_icon.png",
            ),
            GameIcon(
              title: "抽象",
              onPressed: () {
                Navigator.pushNamed(context, "OrientationSettingScreen");
              },
              imagePath: "images/abstract_icon.png",
            ),
            GameIcon(
              title: "打地鼠",
              onPressed: () {
                Navigator.pushNamed(context, "OrientationSettingScreen");
              },
              imagePath: "images/concentration_icon.png",
            ),
          ],
        ),
      ),
    );
  }
}

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             top: screenHeight * 0.15,
//             left: ltrMargin,
//             height: iconHeight,
//             width: iconWidth,
//             child: GameIcon(
//               title: "計算",
//               onPressed: () {
//                 Navigator.pushNamed(context, "ComputeGameScreen");
//               },
//               imagePath: "images/compute_icon.png",
//               parentHeight: iconHeight,
//               parentWidth: iconWidth,
//             ),
//           ),
//           Positioned(
//             top: screenHeight * 0.15,
//             left: ltrMargin * 2 + iconWidth,
//             height: iconHeight,
//             width: iconWidth,
//             child: GameIcon(
//               title: "定向",
//               onPressed: () {
//                 Navigator.pushNamed(context, "OrientationSettingScreen");
//               },
//               imagePath: "images/orientation_icon.png",
//               parentHeight: iconHeight,
//               parentWidth: iconWidth,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

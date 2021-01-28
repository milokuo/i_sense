import 'package:flutter/material.dart';
import '../componenets/InputTypeQuestionBorad.dart';

class ComputeGameScreen extends StatefulWidget {
  @override
  _ComputeGameScreenState createState() => _ComputeGameScreenState();
}

class _ComputeGameScreenState extends State<ComputeGameScreen> {
  int curQuestionId = 0; //id for the index in questionsbook
  int curQuestionStageId = 0; //id for the position in answered question
  bool completed = false;
  String returnedAnswer = "";

  List<dynamic> questionsBook = [
    {"Question": "1000 - 7 = ?", "Answer": 993},
    {"Question": "再試著 -7 呢?", "Answer": 986},
    {"Question": "再試著 -7 呢", "Answer": 979},
    {"Question": "再試著 -7 呢", "Answer": 972},
    {"Question": "再試著 -7 呢", "Answer": 965},
  ];

  var listWidget = <Widget>[
    Flexible(
      child: Image.asset(
        "images/feedback/star_grey.png",
      ),
    ),
    Flexible(
      child: Image.asset(
        "images/feedback/star_grey.png",
      ),
    ),
    Flexible(
      child: Image.asset(
        "images/feedback/star_grey.png",
      ),
    ),
    Flexible(
      child: Image.asset(
        "images/feedback/star_grey.png",
      ),
    ),
    Flexible(
      child: Image.asset(
        "images/feedback/star_grey.png",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (!completed) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Image.asset("images/compute/background.jpg"),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                child: SizedBox(
                  width: screenWidth,
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        ...listWidget,
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InputTypeQuestionBoard(
                question: questionsBook[curQuestionId]["Question"],
                answer: questionsBook[curQuestionId]["Answer"],
                setQuestionState: _setQuestionState,
                setNextAnswer: _setNextAnswer,
              ),
            ],
          ),
        ),
      );
    }
  }

  void _setQuestionState(int id, int state) {
    setState(() {
      if (id != 4) {
        curQuestionId += 1;
      }
      switch (state) {
        //pass
        case -1:
          listWidget[id] = Flexible(
            child: Opacity(
              child: Image.asset("images/feedback/star_grey.png"),
              opacity: 0.5,
            ),
          );
          break;
        //wrong
        case 0:
          listWidget[id] = Flexible(
              child: Image.asset("images/feedback/star_red_cross.png"));
          break;
        //correct
        case 1:
          switch (id) {
            case 0:
              listWidget[id] =
                  Flexible(child: Image.asset("images/feedback/star_red.png"));
              break;

            case 1:
              listWidget[id] =
                  Flexible(child: Image.asset("images/feedback/star_blue.png"));
              break;

            case 2:
              listWidget[id] = Flexible(
                  child: Image.asset("images/feedback/star_green.png"));
              break;

            case 3:
              listWidget[id] = Flexible(
                  child: Image.asset("images/feedback/star_yellow.png"));
              break;

            case 4:
              listWidget[id] = Flexible(
                  child: Image.asset("images/feedback/star_purple.png"));
              break;
          }
      }
    });
  }

  void _setNextAnswer(int id, dynamic answer) {
    questionsBook[id]["answer"] = answer;
  }
}

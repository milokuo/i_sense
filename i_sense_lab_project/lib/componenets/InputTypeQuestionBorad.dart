import 'package:flutter/material.dart';

class InputTypeQuestionBoard extends StatefulWidget {
  InputTypeQuestionBoard({
    Key key,
    @required this.question,
    @required this.answer,
    @required this.setQuestionState,
    this.setNextAnswer,
  }) : super(key: key);
  final String question;
  final dynamic answer;
  final void Function(int id, int state) setQuestionState;
  final void Function(int id, dynamic answer) setNextAnswer;
  @override
  _InputTypeQuestionBoardState createState() => _InputTypeQuestionBoardState();
}

class _InputTypeQuestionBoardState extends State<InputTypeQuestionBoard> {
  String userAnswer;
  int id = 0, correctTimes = 0;
  bool completed = false;

  var feedbackText = [
    {
      "title": "好可惜！",
      "description": "下次還要再接再厲！",
      "imagePath": "images/feedback/animated/crying_moon.gif"
    },
    {
      "title": "好可惜！",
      "description": "下次還要再接再厲！",
      "imagePath": "images/feedback/animated/crying_moon.gif"
    },
    {
      "title": "再加把勁！",
      "description": "您可以做得更好！",
      "imagePath": "images/feedback/animated/cheer_animated.gif"
    },
    {
      "title": "恭喜您！",
      "description": "您離世界頂尖只有一步之遙！",
      "imagePath": "images/feedback/animated/love_animated.gif"
    },
    {
      "title": "接近完美！",
      "description": "聰明得像個十八歲！",
      "imagePath": "images/feedback/animated/rainbow_animated.gif"
    },
    {
      "title": "太厲害啦！",
      "description": "金價屋告讚！",
      "imagePath": "images/feedback/animated/leaves_animated.gif"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var endButtonList = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            child: Text(
              "回到選單",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            color: Colors.greenAccent,
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          RaisedButton(
            child: Text(
              "下一關",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            color: Colors.greenAccent,
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    var jumpFinishButtonList = Row(
      children: [
        SizedBox(
          width: screenWidth * 0.01,
        ),
        Expanded(
          child: RaisedButton(
            child: Center(
              child: Text(
                "跳過",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                ),
              ),
            ),
            color: Colors.grey,
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
              side: BorderSide(color: Colors.black, width: 2),
            ),
            onPressed: () {
              widget.setQuestionState(id, -1);
              id++;
              widget.setNextAnswer(id, widget.answer - 7);
              if (id == 5) this.completed = true;
            },
          ),
        ),
        SizedBox(width: screenWidth * 0.2),
        Expanded(
          child: RaisedButton(
            child: Center(
              child: Text(
                "完成",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            color: Colors.greenAccent,
            colorBrightness: Brightness.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              int state = 0;
              if (userAnswer == widget.answer.toString()) {
                state = 1;
                correctTimes += 1;
              }
              print(correctTimes);
              widget.setQuestionState(id, state);
              id++;
              widget.setNextAnswer(id, int.tryParse(userAnswer) - 7);
              if (id == 5) this.completed = true;
            },
          ),
        ),
        SizedBox(
          width: screenWidth * 0.01,
        ),
      ],
    );

    void _setUserAnswer(e) {
      setState(() {
        userAnswer = e;
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: (() {
        if (!completed)
          return Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                (this.id + 1).toString() + ". " + this.widget.question,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              TextField(
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: "輸入您的答案",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.all(2),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (e) {
                    _setUserAnswer(e);
                  }),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              jumpFinishButtonList,
            ],
          );
        else {
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset(
                        feedbackText[correctTimes]["imagePath"],
                      ),
                      height: screenHeight * 0.18,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          Text(
                            feedbackText[correctTimes]["title"],
                            style: TextStyle(
                                fontSize: 30, color: Colors.deepOrange),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Expanded(
                            child: Text(
                              feedbackText[correctTimes]["description"],
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                      // decoration: BoxDecoration(border: Border.all(width: 2)),
                      height: screenHeight * 0.18,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                endButtonList,
              ],
            ),
          );
        }
      }()),
    );
  }
}

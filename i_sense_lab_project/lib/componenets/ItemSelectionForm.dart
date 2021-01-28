import 'package:flutter/material.dart';

class ItemSelectionForm extends StatefulWidget {
  ItemSelectionForm(
      {Key key,
      this.itemHeightInPercent,
      this.itemWidthInPercent,
      this.ltrMarginInPercent,
      this.utdMarginInPercent,
      this.children})
      : super(key: key);
  final double itemHeightInPercent,
      itemWidthInPercent,
      ltrMarginInPercent,
      utdMarginInPercent;
  final children;
  @override
  _ItemSelectionFormState createState() => _ItemSelectionFormState();
}

class _ItemSelectionFormState extends State<ItemSelectionForm> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double iconHeight = screenHeight * widget.itemHeightInPercent;
    double iconWidth = screenWidth * widget.itemWidthInPercent;
    int placeItemsCount = 0;
    double curRemainedWidth = 1 - widget.ltrMarginInPercent;
    while (curRemainedWidth > 0) {
      curRemainedWidth -=
          (widget.itemHeightInPercent + widget.ltrMarginInPercent);
      placeItemsCount++;
    }
    double ltrMargin =
        (screenWidth - placeItemsCount * iconWidth) / (placeItemsCount + 1);
    double utdMargin = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.15,
            left: ltrMargin,
            height: iconHeight,
            width: iconWidth,
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: ltrMargin * 2 + iconWidth,
            height: iconHeight,
            width: iconWidth,
          ),
        ],
      ),
    );
  }
}

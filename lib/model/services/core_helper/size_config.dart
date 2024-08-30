import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double height;
  static late double width;
  static late double textSize;
  static late double imageSize;
  static bool isPortrait = true;

  void initialize(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      isPortrait = true;
    } else {
      height = constraints.maxWidth;
      width = constraints.maxWidth;
      isPortrait = false;
    }
    textSize = height * 0.5;
    imageSize = width;
  }
}

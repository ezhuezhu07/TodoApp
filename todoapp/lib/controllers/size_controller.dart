import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeController extends GetxController {
  late double screenHeight;
  late double screenWidth;

  // Sign In Page

  late double appTitleTop;
  late double appTitleLeft;
  late double appTitleHeight;
  late double appTitleWidth;

  late double signInEmailTextFieldTop;
  late double signInEmailTextFieldLeft;
  late double signInEmailTextFieldHeight;
  late double signInEmailTextFieldWidth;

  late double signInPasswordFieldTop;
  late double signInPasswordFieldLeft;
  late double signInPasswordFieldHeight;
  late double signInPasswordFieldWidth;

  late double signInButtonTop;
  late double signInButtonLeft;
  late double signInButtonHeight;
  late double signInButtonWidth;

  void setSize(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // Sign In Page
    appTitleTop = screenHeight * 0.1;
    appTitleLeft = screenWidth * 0.45;
    appTitleHeight = screenHeight * 0.2;
    appTitleWidth = screenWidth * 0.15;

    signInEmailTextFieldTop = screenHeight * 0.3;
    signInEmailTextFieldLeft = screenWidth * 0.5;
    signInEmailTextFieldHeight = screenHeight * 0.2;
    signInEmailTextFieldWidth = screenWidth * 0.25;

    signInPasswordFieldTop = screenHeight * 0.5;
    signInPasswordFieldLeft = screenWidth * 0.5;
    signInPasswordFieldHeight = screenHeight * 0.2;
    signInPasswordFieldWidth = screenWidth * 0.25;

    signInButtonTop = screenHeight * 0.7;
    signInButtonLeft = screenWidth * 0.55;
    signInButtonHeight = screenHeight * 0.2;
    signInButtonWidth = screenWidth * 0.25;
  }
}

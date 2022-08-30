import 'package:flutter/material.dart';

class SizeProvider with ChangeNotifier {
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

  late double signInCreateAccountLinkTop;
  late double signInCreateAccountLinkLeft;
  late double signInCreateAccountLinkHeight;
  late double signInCreateAccountLinkWidth;

  late double signInWithGoogleButtonTop;
  late double signInWithGoogleButtonLeft;
  late double signInWithGoogleButtonHeight;
  late double signInWithGoogleButtonWidth;

  late double todoLottieAnimationTop;
  late double todoLottieAnimationLeft;
  late double todoLottieAnimationHeight;
  late double todoLottieAnimationWidth;

  // Sign Up Page
  late double signUpTitleTop;
  late double signUpTitleLeft;
  late double signUpTitleHeight;
  late double signUpTitleWidth;

  late double signUpEmailTextFieldTop;
  late double signUpEmailTextFieldLeft;
  late double signUpEmailTextFieldHeight;
  late double signUpEmailTextFieldWidth;

  late double signUpPasswordFieldTop;
  late double signUpPasswordFieldLeft;
  late double signUpPasswordFieldHeight;
  late double signUpPasswordFieldWidth;

  late double signUpConfirmPasswordFieldTop;
  late double signUpConfirmPasswordFieldLeft;
  late double signUpConfirmPasswordFieldHeight;
  late double signUpConfirmPasswordFieldWidth;

  late double signUpButtonTop;
  late double signUpButtonLeft;
  late double signUpButtonHeight;
  late double signUpButtonWidth;

  // dash board page
  late double dashBoardTitleContainerTop;
  late double dashBoardTitleContainerLeft;
  late double dashBoardTitleContainerHeight;
  late double dashBoardTitleContainerWidth;

  late double todoStatCardTop;
  late double todoStatCardLeft;
  late double todoStatCardHeight;
  late double todoStatCardWidth;

  late double todoListViewTop;
  late double todoListViewLeft;
  late double todoListViewHeight;
  late double todoListViewWidth;

  // create Todo Page
  late double addPageTitleTop;
  late double addPageTitleLeft;
  late double addPageTitleHeight;
  late double addPageTitleWidth;

  late double addTodoTypeIconTop;
  late double addTodoTypeIconLeft;
  late double addTodoTypeIconHeight;
  late double addTodoTypeIconWidth;

  late double addTodoTypeListTop;
  late double addTodoTypeListLeft;
  late double addTodoTypeListHeight;
  late double addTodoTypeListWidth;

  late double addTodoTitleTextFieldTop;
  late double addTodoTitleTextFieldLeft;
  late double addTodoTitleTextFieldHeight;
  late double addTodoTitleTextFieldWidth;

  late double addTodoDescriptionTextAreaTop;
  late double addTodoDescriptionTextAreaLeft;
  late double addTodoDescriptionTextAreaHeight;
  late double addTodoDescriptionTextAreaWidth;

  late double addTodoRemainderTimeTop;
  late double addTodoRemainderTimeLeft;
  late double addTodoRemainderTimeHeight;
  late double addTodoRemainderTimeWidth;

  late double addTodoFormSubmitButtonTop;
  late double addTodoFormSubmitButtonLeft;
  late double addTodoFormSubmitButtonHeight;
  late double addTodoFormSubmitButtonWidth;

  //update
  late double editPageTitleTop;
  late double editPageTitleLeft;
  late double editPageTitleHeight;
  late double editPageTitleWidth;

  late double editTodoTypeIconTop;
  late double editTodoTypeIconLeft;
  late double editTodoTypeIconHeight;
  late double editTodoTypeIconWidth;

  late double editTodoTypeListTop;
  late double editTodoTypeListLeft;
  late double editTodoTypeListHeight;
  late double editTodoTypeListWidth;

  late double editTodoTitleTextFieldTop;
  late double editTodoTitleTextFieldLeft;
  late double editTodoTitleTextFieldHeight;
  late double editTodoTitleTextFieldWidth;

  late double editTodoDescriptionTextAreaTop;
  late double editTodoDescriptionTextAreaLeft;
  late double editTodoDescriptionTextAreaHeight;
  late double editTodoDescriptionTextAreaWidth;

  late double editTodoRemainderTimeTop;
  late double editTodoRemainderTimeLeft;
  late double editTodoRemainderTimeHeight;
  late double editTodoRemainderTimeWidth;

  late double editTodoFormSubmitButtonTop;
  late double editTodoFormSubmitButtonLeft;
  late double editTodoFormSubmitButtonHeight;
  late double editTodoFormSubmitButtonWidth;

  // font size
  late double fontSize1;
  late double fontSize2;
  late double fontSize3;
  late double fontSize4;
  late double fontSize5;

  void setSize(BuildContext context) async {
    print('Size Provider is called');
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // Sign In Page
    appTitleTop = screenHeight * 0.1;
    appTitleLeft = screenWidth * 0.05;
    appTitleHeight = screenHeight * 0.1;
    appTitleWidth = screenWidth * 0.9;

    signInEmailTextFieldTop = screenHeight * 0.25;
    signInEmailTextFieldLeft = screenWidth * 0.05;
    signInEmailTextFieldHeight = screenHeight * 0.1;
    signInEmailTextFieldWidth = screenWidth * 0.9;

    signInPasswordFieldTop = screenHeight * 0.4;
    signInPasswordFieldLeft = screenWidth * 0.05;
    signInPasswordFieldHeight = screenHeight * 0.1;
    signInPasswordFieldWidth = screenWidth * 0.9;

    signInButtonTop = screenHeight * 0.55;
    signInButtonLeft = screenWidth * 0.3;
    signInButtonHeight = screenHeight * 0.075;
    signInButtonWidth = screenWidth * 0.4;

    signInCreateAccountLinkTop = screenHeight * 0.65;
    signInCreateAccountLinkLeft = screenWidth * 0.3;
    signInCreateAccountLinkHeight = screenHeight * 0.1;
    signInCreateAccountLinkWidth = screenWidth * 0.4;

    signInWithGoogleButtonTop = screenHeight * 0.7;
    signInWithGoogleButtonLeft = screenWidth * 0.05;
    signInWithGoogleButtonHeight = screenHeight * 0.075;
    signInWithGoogleButtonWidth = screenWidth * 0.9;

    todoLottieAnimationTop = screenHeight * 0.3;
    todoLottieAnimationLeft = 0;
    todoLottieAnimationHeight = screenHeight * 0.3;
    todoLottieAnimationWidth = screenWidth;

    // Sign up page
    signUpTitleTop = screenHeight * 0.1;
    signUpTitleLeft = screenWidth * 0.05;
    signUpTitleHeight = screenHeight * 0.1;
    signUpTitleWidth = screenWidth * 0.9;

    signUpEmailTextFieldTop = screenHeight * 0.25;
    signUpEmailTextFieldLeft = screenWidth * 0.05;
    signUpEmailTextFieldHeight = screenHeight * 0.1;
    signUpEmailTextFieldWidth = screenWidth * 0.9;

    signUpPasswordFieldTop = screenHeight * 0.4;
    signUpPasswordFieldLeft = screenWidth * 0.05;
    signUpPasswordFieldHeight = screenHeight * 0.1;
    signUpPasswordFieldWidth = screenWidth * 0.9;

    signUpConfirmPasswordFieldTop = screenHeight * 0.55;
    signUpConfirmPasswordFieldLeft = screenWidth * 0.05;
    signUpConfirmPasswordFieldHeight = screenHeight * 0.1;
    signUpConfirmPasswordFieldWidth = screenWidth * 0.9;

    signUpButtonTop = screenHeight * 0.7;
    signUpButtonLeft = screenWidth * 0.3;
    signUpButtonHeight = screenHeight * 0.075;
    signUpButtonWidth = screenWidth * 0.4;

    // dashboard page
    dashBoardTitleContainerTop = 0;
    dashBoardTitleContainerLeft = 0;
    dashBoardTitleContainerHeight = screenHeight * (1 / 3);
    dashBoardTitleContainerWidth = screenWidth * (1 / 2);

    todoStatCardTop = 0;
    todoStatCardLeft = screenWidth * (1 / 2);
    todoStatCardHeight = screenHeight * (1 / 3);
    todoStatCardWidth = screenWidth * (1 / 2);

    todoListViewTop = screenHeight * (1 / 3);
    todoListViewLeft = 0;
    todoListViewHeight = screenHeight * (2 / 3);
    todoListViewWidth = screenWidth;

    // create Todo Page
    addPageTitleTop = screenHeight * 0.1;
    addPageTitleLeft = screenWidth * 0.05;
    addPageTitleHeight = screenHeight * (0.05);
    addPageTitleWidth = screenWidth * 0.9;

    addTodoTypeIconTop = screenHeight * 0.175;
    addTodoTypeIconLeft = screenWidth * 0.05;
    addTodoTypeIconHeight = screenHeight * (0.1);
    addTodoTypeIconWidth = screenWidth * 0.9;

    addTodoTypeListTop = screenHeight * (0.3);
    addTodoTypeListLeft = screenWidth * 0.05;
    addTodoTypeListHeight = screenHeight * (0.1);
    addTodoTypeListWidth = screenWidth * 0.9;

    addTodoTitleTextFieldTop = screenHeight * (0.4);
    addTodoTitleTextFieldLeft = screenWidth * 0.05;
    addTodoTitleTextFieldHeight = screenHeight * (0.1);
    addTodoTitleTextFieldWidth = screenWidth * 0.9;

    addTodoRemainderTimeTop = screenHeight * 0.5;
    addTodoRemainderTimeLeft = screenWidth * 0.05;
    addTodoRemainderTimeHeight = screenHeight * (0.075);
    addTodoRemainderTimeWidth = screenWidth * 0.9;

    addTodoDescriptionTextAreaTop = screenHeight * (0.6);
    addTodoDescriptionTextAreaLeft = screenWidth * 0.05;
    addTodoDescriptionTextAreaHeight = screenHeight * (0.2);
    addTodoDescriptionTextAreaWidth = screenWidth * 0.9;

    addTodoFormSubmitButtonTop = screenHeight * (0.85);
    addTodoFormSubmitButtonLeft = screenWidth * 0.05;
    addTodoFormSubmitButtonHeight = screenHeight * (0.05);
    addTodoFormSubmitButtonWidth = screenWidth * 0.9;

    // update
    editPageTitleTop = screenHeight * 0.1;
    editPageTitleLeft = screenWidth * 0.05;
    editPageTitleHeight = screenHeight * (0.05);
    editPageTitleWidth = screenWidth * 0.9;

    editTodoTypeIconTop = screenHeight * 0.175;
    editTodoTypeIconLeft = screenWidth * 0.05;
    editTodoTypeIconHeight = screenHeight * (0.1);
    editTodoTypeIconWidth = screenWidth * 0.9;

    editTodoTypeListTop = screenHeight * (0.3);
    editTodoTypeListLeft = screenWidth * 0.05;
    editTodoTypeListHeight = screenHeight * (0.1);
    editTodoTypeListWidth = screenWidth * 0.9;

    editTodoTitleTextFieldTop = screenHeight * (0.4);
    editTodoTitleTextFieldLeft = screenWidth * 0.05;
    editTodoTitleTextFieldHeight = screenHeight * (0.1);
    editTodoTitleTextFieldWidth = screenWidth * 0.9;

    editTodoRemainderTimeTop = screenHeight * 0.5;
    editTodoRemainderTimeLeft = screenWidth * 0.05;
    editTodoRemainderTimeHeight = screenHeight * (0.075);
    editTodoRemainderTimeWidth = screenWidth * 0.9;

    editTodoDescriptionTextAreaTop = screenHeight * (0.6);
    editTodoDescriptionTextAreaLeft = screenWidth * 0.05;
    editTodoDescriptionTextAreaHeight = screenHeight * (0.2);
    editTodoDescriptionTextAreaWidth = screenWidth * 0.9;

    editTodoFormSubmitButtonTop = screenHeight * (0.85);
    editTodoFormSubmitButtonLeft = screenWidth * 0.05;
    editTodoFormSubmitButtonHeight = screenHeight * (0.05);
    editTodoFormSubmitButtonWidth = screenWidth * 0.9;

    // font size
    fontSize1 = screenHeight * 0.055;
    fontSize2 = screenHeight * 0.045;
    fontSize3 = screenHeight * 0.035;
    fontSize4 = screenHeight * 0.025;
    fontSize5 = screenHeight * 0.015;
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }
}

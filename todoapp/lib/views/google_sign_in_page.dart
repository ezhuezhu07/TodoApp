// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/providers/sign_in_provider.dart';
import 'package:todoapp/providers/size_providers.dart';

class GoogleSignInPage extends StatelessWidget {
  // const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SizeProvider>(context, listen: false).setSize(context);

    return Material(
      child: Scaffold(
        body: Consumer<SizeProvider>(builder: (context, sizeProvider, child) {
          return Container(
            height: sizeProvider.screenHeight,
            width: sizeProvider.screenWidth,
            color: darkmgray,
            child: Stack(
              children: [
                Positioned(
                    top: sizeProvider.appTitleTop,
                    left: sizeProvider.appTitleLeft,
                    child: SizedBox(
                        height: sizeProvider.appTitleHeight,
                        width: sizeProvider.appTitleWidth,
                        child: Center(
                            child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Todo App",
                            style: TextStyle(
                              color: blueShade,
                              fontSize: sizeProvider.fontSize1,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )))),
                Positioned(
                  top: sizeProvider.todoLottieAnimationTop,
                  left: sizeProvider.todoListViewLeft,
                  child: SizedBox(
                    height: sizeProvider.todoLottieAnimationHeight,
                    width: sizeProvider.todoLottieAnimationWidth,
                    child:
                        Center(child: Lottie.asset('assets/lottie_todo.json')),
                  ),
                ),
                Positioned(
                  top: sizeProvider.signInWithGoogleButtonTop,
                  left: sizeProvider.signInWithGoogleButtonLeft,
                  child: SizedBox(
                    height: sizeProvider.signInWithGoogleButtonHeight,
                    width: sizeProvider.signInWithGoogleButtonWidth,
                    child: ElevatedButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: blueShade,
                        size: 32,
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(blueShadeLight),
                          shadowColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(blueShade),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return blueShadeHover;
                            }
                            if (states.contains(MaterialState.pressed)) {
                              return bluemid;
                            }
                            return null; // Defer to the widget's default.
                          })),
                      onPressed: () async {
                        await AuthProvider.googleLogin();
                      },
                      label: Consumer<SignInProvider>(
                          builder: (context, signInProvider, child) {
                        return !signInProvider.isSignInRequesting
                            ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Sign In With Google',
                                  style: TextStyle(
                                    fontSize: sizeProvider.fontSize4,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: sizeProvider.screenWidth * 0.01,
                                height: sizeProvider.screenWidth * 0.01,
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.red)),
                              );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

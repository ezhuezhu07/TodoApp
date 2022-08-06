// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/controllers/google_sign_in.dart';
import 'package:todoapp/controllers/sign_in_controller.dart';
import 'package:todoapp/controllers/size_controller.dart';

class SignInPage extends StatelessWidget {
  // const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sizes are assigned based on Screen Size
    // SizeController sizeController = Get.find<SizeController>();
    SizeController sizeController = Get.put(SizeController());
    GoogleSignInController googleSignInController =
        Get.put(GoogleSignInController());
    sizeController.setSize(context);
    return GetBuilder<SignInController>(
      id: 'SignInPage',
      init: SignInController(),
      builder: (controller) {
        // Size screensize = MediaQuery.of(context).size;
        // SizeController sizeController = Get.put(SizeController());
        // sizeController.setSize(context);

        return Material(
          child: Container(
            height: sizeController.screenHeight,
            width: sizeController.screenWidth,
            color: darkmgray,
            child: Stack(
              children: [
                Positioned(
                    top: sizeController.appTitleTop,
                    left: sizeController.appTitleLeft,
                    child: SizedBox(
                        height: sizeController.appTitleHeight,
                        width: sizeController.appTitleWidth,
                        child: Center(
                            child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Todo App",
                            style: TextStyle(
                              color: blueShade,
                              fontSize: sizeController.fontSize1,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )))),
                Positioned(
                    top: sizeController.signInEmailTextFieldTop,
                    left: sizeController.signInEmailTextFieldLeft,
                    child: SizedBox(
                        height: sizeController.signInEmailTextFieldHeight,
                        width: sizeController.signInEmailTextFieldWidth,
                        child: TextFormField(
                          controller: controller.addTextController(
                              controller.signInEmailTextField,
                              initialValue: ""),
                          focusNode: controller
                              .addFocusNode(controller.signInEmailTextField),

                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator: (String? value) {
                            return controller
                                .signInEmailTextFieldValidation(value);
                          },
                          textAlign: TextAlign.center,
                          onChanged: (value) {},

                          style: (TextStyle(
                              fontSize: sizeController.fontSize4,
                              color: blueShade,
                              fontWeight: FontWeight.normal)),

                          //more options below, uncomment to activate

                          keyboardType: TextInputType.emailAddress,
                          // cursorColor: ,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: bluemid,
                              // color: controller.fgIconColor
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bluemid)),
                            labelText: 'Email Id',
                            labelStyle: (TextStyle(
                                fontSize: sizeController.fontSize4,
                                color: bluemid,
                                fontWeight: FontWeight.normal)),
                            errorStyle: (TextStyle(
                                fontSize: sizeController.fontSize5,
                                color: cherry,
                                fontWeight: FontWeight.normal)),
                          ),
                          //cursorHeight: screensize.height*0.05,
                        ))),
                Positioned(
                    top: sizeController.signInPasswordFieldTop,
                    left: sizeController.signInPasswordFieldLeft,
                    child: GetBuilder<SignInController>(
                      id: controller.signInPasswordField,
                      builder: (_) {
                        return SizedBox(
                            height: sizeController.signInPasswordFieldHeight,
                            width: sizeController.signInPasswordFieldWidth,
                            child: TextFormField(
                              // readOnly: controller.isSignInRequesting,
                              controller: controller.addTextController(
                                  controller.signInPasswordField,
                                  initialValue: ""),
                              focusNode: controller
                                  .addFocusNode(controller.signInPasswordField),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              onSaved: (String? value) {},
                              validator: (String? value) {
                                return controller
                                    .signInPasswordFieldValidation(value);
                              },

                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                //on change ULM here
                              },

                              //All textfield options have to be made as properties of textfield widget
                              style: (TextStyle(
                                fontSize: sizeController.fontSize4,
                                color: blueShade,
                              )),
                              keyboardType: TextInputType.text,
                              cursorColor: blueShade,
                              obscureText: !controller.isPasswordVisible(),

                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: bluemid)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: bluemid)),
                                labelText: 'Password',
                                labelStyle: (TextStyle(
                                    fontSize: sizeController.fontSize4,
                                    color: bluemid,
                                    fontWeight: FontWeight.normal)),
                                errorStyle: (TextStyle(
                                    fontSize: sizeController.fontSize5,
                                    color: Colors.red,
                                    fontWeight: FontWeight.normal)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible()
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: controller.isPasswordVisible()
                                        ? blueShade
                                        : bluemid,
                                  ),
                                  onPressed: () {
                                    controller
                                        .togglePasswordVisibleState(); //Any logic will have ULM as suffix
                                  },
                                ),
                              ),
                            ));
                      },
                    )),
                Positioned(
                  top: sizeController.signInButtonTop,
                  left: sizeController.signInButtonLeft,
                  child: SizedBox(
                    height: sizeController.signInButtonHeight,
                    width: sizeController.signInButtonWidth,
                    child: ElevatedButton(
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
                        if (controller.isFormValid()) {
                          !controller.isSignInRequesting
                              ? controller.signInAction(context)
                              : null;
                        } else {
                          controller.focusOnNextInvalid();
                        }

                        // await googleSignInController.googleLogin();
                      },
                      child: !controller.isSignInRequesting
                          ? FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: sizeController.fontSize4,
                                ),
                              ),
                            )
                          : SizedBox(
                              width: sizeController.screenWidth * 0.01,
                              height: sizeController.screenWidth * 0.01,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red)),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: sizeController.signInCreateAccountLinkTop,
                  left: sizeController.signInCreateAccountLinkLeft,
                  child: SizedBox(
                    height: sizeController.signInCreateAccountLinkHeight,
                    width: sizeController.signInCreateAccountLinkWidth,
                    child: RichText(
                      // text: ,
                      text: TextSpan(
                          style: TextStyle(
                            color: bluemid,
                            fontSize: sizeController.fontSize5,
                          ),
                          text: 'Not have an account? ',
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed('/SignUpPage');
                                  },
                                text: 'Create New',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: bluemid,
                                )),
                          ]),
                    ),
                  ),
                ),
                Positioned(
                  top: sizeController.signInWithGoogleButtonTop,
                  left: sizeController.signInWithGoogleButtonLeft,
                  child: SizedBox(
                    height: sizeController.signInWithGoogleButtonHeight,
                    width: sizeController.signInWithGoogleButtonWidth,
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
                        await googleSignInController.googleLogin();
                      },
                      label: !controller.isSignInRequesting
                          ? FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Sign In With Google',
                                style: TextStyle(
                                  fontSize: sizeController.fontSize4,
                                ),
                              ),
                            )
                          : SizedBox(
                              width: sizeController.screenWidth * 0.01,
                              height: sizeController.screenWidth * 0.01,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red)),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

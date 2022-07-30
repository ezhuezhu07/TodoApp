// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/controllers/sign_in_controller.dart';
import 'package:todoapp/controllers/size_controller.dart';

class SignInPage extends StatelessWidget {
  // const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sizes are assigned based on Screen Size
    // SizeController sizeController = Get.find<SizeController>();
    SizeController sizeController = Get.put(SizeController());
    sizeController.setSize(context);

    return GetBuilder<SignInController>(
      id: 'SignInPage',
      init: SignInController(),
      builder: (controller) {
        // Size screensize = MediaQuery.of(context).size;
        // SizeController sizeController = Get.put(SizeController());
        // sizeController.setSize(context);
        return Scaffold(
          body: Container(
            height: sizeController.screenHeight,
            width: sizeController.screenWidth,
            color: bgColor1,
            child: Stack(
              children: [
                Positioned(
                    top: sizeController.appTitleTop,
                    left: sizeController.appTitleLeft,
                    child: SizedBox(
                        height: sizeController.appTitleHeight,
                        width: sizeController.appTitleWidth,
                        child: Center(
                            child: Text(
                          "Todo App",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
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
                              // fontSize: screensize.height * 0.02,
                              //fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),

                          //more options below, uncomment to activate

                          keyboardType: TextInputType.emailAddress,
                          // cursorColor: ,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    // color: controller.fgIconColor
                                    )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    // color: controller.fgIconColor
                                    )),
                            labelText: 'Email ID',
                            labelStyle: (TextStyle(
                                fontSize: sizeController.screenHeight * 0.02,
                                // color: controller.fgIconColor,
                                fontWeight: FontWeight.w400)),
                            errorStyle: (TextStyle(
                                fontSize: sizeController.screenHeight * 0.015,
                                color: Colors.red,
                                fontWeight: FontWeight.w400)),
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
                                  fontSize: sizeController.screenHeight * 0.030,
                                  //fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              obscureText: !controller.isPasswordVisible(),

                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: 'Password',
                                labelStyle: (TextStyle(
                                    fontSize:
                                        sizeController.screenHeight * 0.02,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                                errorStyle: (TextStyle(
                                    fontSize:
                                        sizeController.screenHeight * 0.015,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: controller.isPasswordVisible()
                                        ? Colors.white
                                        : Colors.amber,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF049fd9)),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue.shade900.withOpacity(1);
                                  }
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.blue.shade800
                                        .withOpacity(0.5);
                                  }
                                  return null; // Defer to the widget's default.
                                })),
                            onPressed: () => {
                                  !controller.isSignInRequesting
                                      ? controller.signInAction(context)
                                      : null
                                },
                            child: !controller.isSignInRequesting
                                ? Text('SignIn')
                                : SizedBox(
                                    width: sizeController.screenWidth * 0.01,
                                    height: sizeController.screenWidth * 0.01,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.red)),
                                  )))),
              ],
            ),
          ),
        );
      },
    );
  }
}

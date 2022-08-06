// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/controllers/sign_up_controller.dart';
import 'package:todoapp/controllers/size_controller.dart';

class SignUpPage extends StatelessWidget {
  // const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sizes are assigned based on Screen Size
    SizeController sizeController = Get.find<SizeController>();

    return GetBuilder<SignUpController>(
      id: 'SignUpPage',
      init: SignUpController(),
      builder: (controller) {
        // Size screensize = MediaQuery.of(context).size;
        // SizeController sizeController = Get.put(SizeController());
        // sizeController.setSize(context);
        return Scaffold(
          body: Container(
            height: sizeController.screenHeight,
            width: sizeController.screenWidth,
            color: darkmgray,
            child: Stack(
              children: [
                Positioned(
                    top: sizeController.signUpTitleTop,
                    left: sizeController.signUpTitleLeft,
                    child: SizedBox(
                        height: sizeController.signUpTitleHeight,
                        width: sizeController.signUpTitleWidth,
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
                    top: sizeController.signUpEmailTextFieldTop,
                    left: sizeController.signUpEmailTextFieldLeft,
                    child: SizedBox(
                        height: sizeController.signUpEmailTextFieldHeight,
                        width: sizeController.signUpEmailTextFieldWidth,
                        child: TextFormField(
                          controller: controller.addTextController(
                              controller.signUpEmailTextField,
                              initialValue: ""),
                          focusNode: controller
                              .addFocusNode(controller.signUpEmailTextField),

                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator: (String? value) {
                            return controller
                                .signUpEmailTextFieldValidation(value);
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
                    top: sizeController.signUpPasswordFieldTop,
                    left: sizeController.signUpPasswordFieldLeft,
                    child: GetBuilder<SignUpController>(
                      id: controller.signUpPasswordField,
                      builder: (_) {
                        return SizedBox(
                            height: sizeController.signUpPasswordFieldHeight,
                            width: sizeController.signUpPasswordFieldWidth,
                            child: TextFormField(
                              // readOnly: controller.isSignInRequesting,
                              controller: controller.addTextController(
                                  controller.signUpPasswordField,
                                  initialValue: ""),
                              focusNode: controller
                                  .addFocusNode(controller.signUpPasswordField),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              onSaved: (String? value) {},
                              validator: (String? value) {
                                return controller
                                    .signUpPasswordFieldValidation(value);
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
                              cursorColor: Colors.white,
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
                    top: sizeController.signUpConfirmPasswordFieldTop,
                    left: sizeController.signUpConfirmPasswordFieldLeft,
                    child: GetBuilder<SignUpController>(
                      id: controller.signUpConfirmPasswordField,
                      builder: (_) {
                        return SizedBox(
                            height:
                                sizeController.signUpConfirmPasswordFieldHeight,
                            width:
                                sizeController.signUpConfirmPasswordFieldWidth,
                            child: TextFormField(
                              // readOnly: controller.isSignInRequesting,
                              controller: controller.addTextController(
                                  controller.signUpConfirmPasswordField,
                                  initialValue: ""),
                              focusNode: controller.addFocusNode(
                                  controller.signUpConfirmPasswordField),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              onSaved: (String? value) {},
                              validator: (String? value) {
                                return controller
                                    .signUpConfirmPasswordFieldValidation(
                                        value);
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
                              obscureText:
                                  !controller.isConfirmPasswordVisible(),

                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: bluemid)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: bluemid)),
                                labelText: 'Confirm Password',
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
                                    controller.isConfirmPasswordVisible()
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: controller.isConfirmPasswordVisible()
                                        ? blueShade
                                        : bluemid,
                                  ),
                                  onPressed: () {
                                    controller
                                        .toggleConfirmPasswordVisibleState(); //Any logic will have ULM as suffix
                                  },
                                ),
                              ),
                            ));
                      },
                    )),
                Positioned(
                    top: sizeController.signUpButtonTop,
                    left: sizeController.signUpButtonLeft,
                    child: SizedBox(
                        height: sizeController.signUpButtonHeight,
                        width: sizeController.signUpButtonWidth,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        blueShadeLight),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
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
                                await controller.signUpAction(context);
                                if (FirebaseAuth.instance.currentUser != null) {
                                  Get.offNamed('/');
                                }
                              } else {
                                controller.focusOnNextInvalid();
                              }
                            },
                            child: !controller.isSignUpRequesting
                                ? FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text('Sign Up'))
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

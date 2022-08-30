// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/providers/sign_in_provider.dart';
import 'package:todoapp/providers/size_providers.dart';

class SignInPage extends StatelessWidget {
  // const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInProvider signInProvider =
        Provider.of<SignInProvider>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
    return Consumer<SizeProvider>(builder: (context, sizeProvider, child) {
      Provider.of<SizeProvider>(context, listen: false).setSize(context);
      return Material(
        child: Container(
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
                  top: sizeProvider.signInEmailTextFieldTop,
                  left: sizeProvider.signInEmailTextFieldLeft,
                  child: SizedBox(
                      height: sizeProvider.signInEmailTextFieldHeight,
                      width: sizeProvider.signInEmailTextFieldWidth,
                      child: Consumer<SignInProvider>(
                          builder: (context, provider, _) {
                        return TextFormField(
                          controller: provider.addTextController(
                              provider.signInEmailTextField,
                              initialValue: ""),
                          focusNode: provider
                              .addFocusNode(provider.signInEmailTextField),

                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator: (String? value) {
                            return provider
                                .signInEmailTextFieldValidation(value);
                          },
                          textAlign: TextAlign.center,
                          onChanged: (value) {},

                          style: (TextStyle(
                              fontSize: sizeProvider.fontSize4,
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
                              // color: provider.fgIconColor
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bluemid)),
                            labelText: 'Email Id',
                            labelStyle: (TextStyle(
                                fontSize: sizeProvider.fontSize4,
                                color: bluemid,
                                fontWeight: FontWeight.normal)),
                            errorStyle: (TextStyle(
                                fontSize: sizeProvider.fontSize5,
                                color: cherry,
                                fontWeight: FontWeight.normal)),
                          ),
                          //cursorHeight: screensize.height*0.05,
                        );
                      }))),
              Positioned(
                  top: sizeProvider.signInPasswordFieldTop,
                  left: sizeProvider.signInPasswordFieldLeft,
                  child: Consumer<SignInProvider>(
                    // id: provider.signInPasswordField,
                    builder: (_, mypro, __) {
                      return SizedBox(
                          height: sizeProvider.signInPasswordFieldHeight,
                          width: sizeProvider.signInPasswordFieldWidth,
                          child: Consumer<SignInProvider>(
                              builder: (context, provider, _) {
                            return TextFormField(
                              // readOnly: provider.isSignInRequesting,
                              controller: mypro.addTextController(
                                  mypro.signInPasswordField,
                                  initialValue: ""),
                              focusNode: provider
                                  .addFocusNode(mypro.signInPasswordField),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              onSaved: (String? value) {},
                              validator: (String? value) {
                                return mypro
                                    .signInPasswordFieldValidation(value);
                              },

                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                //on change ULM here
                              },

                              //All textfield options have to be made as properties of textfield widget
                              style: (TextStyle(
                                fontSize: sizeProvider.fontSize4,
                                color: blueShade,
                              )),
                              keyboardType: TextInputType.text,
                              cursorColor: blueShade,
                              obscureText: !provider.isPasswordVisible(),

                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: bluemid)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: bluemid)),
                                labelText: 'Password',
                                labelStyle: (TextStyle(
                                    fontSize: sizeProvider.fontSize4,
                                    color: bluemid,
                                    fontWeight: FontWeight.normal)),
                                errorStyle: (TextStyle(
                                    fontSize: sizeProvider.fontSize5,
                                    color: Colors.red,
                                    fontWeight: FontWeight.normal)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.isPasswordVisible()
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: provider.isPasswordVisible()
                                        ? blueShade
                                        : bluemid,
                                  ),
                                  onPressed: () {
                                    provider
                                        .togglePasswordVisibleState(); //Any logic will have ULM as suffix
                                  },
                                ),
                              ),
                            );
                          }));
                    },
                  )),
              Positioned(
                top: sizeProvider.signInButtonTop,
                left: sizeProvider.signInButtonLeft,
                child: SizedBox(
                  height: sizeProvider.signInButtonHeight,
                  width: sizeProvider.signInButtonWidth,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(blueShadeLight),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(blueShade),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
                      if (signInProvider.isFormValid()) {
                        !signInProvider.isSignInRequesting
                            ? signInProvider.signInAction(context)
                            : null;
                      } else {
                        signInProvider.focusOnNextInvalid();
                      }

                      // await googleSignInController.googleLogin();
                    },
                    child: Consumer<SignInProvider>(
                        builder: (context, provider, _) {
                      return !provider.isSignInRequesting
                          ? FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Sign In',
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
              Positioned(
                top: sizeProvider.signInCreateAccountLinkTop,
                left: sizeProvider.signInCreateAccountLinkLeft,
                child: SizedBox(
                  height: sizeProvider.signInCreateAccountLinkHeight,
                  width: sizeProvider.signInCreateAccountLinkWidth,
                  child: RichText(
                    // text: ,
                    text: TextSpan(
                        style: TextStyle(
                          color: bluemid,
                          fontSize: sizeProvider.fontSize5,
                        ),
                        text: 'Not have an account? ',
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Get.toNamed('/SignUpPage');
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(blueShadeLight),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(blueShade),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
                      // await googleSignInController.googleLogin();
                    },
                    label: Consumer<SignInProvider>(
                        builder: (context, provider, _) {
                      return !provider.isSignInRequesting
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
        ),
      );
    });
    // return Consumer<SignInProvider>(builder: (context, provider, child) {

    //   // return
    // });
  }
}

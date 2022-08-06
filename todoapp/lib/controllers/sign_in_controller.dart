import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/auth_controller.dart';

class SignInController extends GetxController {
  // ? widget names
  final String appTitle = 'appTitle';
  final String signInEmailTextField = 'signInEmailTextField';
  final String signInPasswordField = 'signInPasswordField';
  final String signInButton = 'signInButton';
  late AuthController authController;

  // ? password field variable
  bool _passwordVisible = false;

  // ?  sign in requesting
  final bool _isSignInRequesting = false;
  bool get isSignInRequesting => _isSignInRequesting;

  // Textfield variables
  late Map<String, TextEditingController>
      textControllers; //map of all fields controllers

  late Map<String, FocusNode> focusNodes; //map of all fields focus nodes

  late Map<String, bool> validations; //map of all fields validation status

  late Map<String, bool> enabledStatus; //map of all enabled fields status

  // TextField validation functions
  TextEditingController? getTextController(String id) {
    return textControllers[id];
  }

  TextEditingController? addTextController(String id,
      {String initialValue = 'default'}) {
    textControllers.putIfAbsent(
        id, () => TextEditingController(text: initialValue));
    return textControllers[id];
  }

  FocusNode? getFocusNode(String id) {
    return focusNodes[id];
  }

  FocusNode? addFocusNode(String id) {
    focusNodes.putIfAbsent(id, () => FocusNode());
    addValidation(id);
    return focusNodes[id];
  }

  bool? addValidation(String id) {
    validations.putIfAbsent(id, () => false);
    return validations[id];
  }

  bool getValidation(String id) {
    if (validations[id] == null) {
      validations[id] = false;
    }
    return validations[id]!;
  }

  void updateValidation(String id, bool change) {
    validations[id] = change;
    validations.update(id, (value) => change);
  }

  bool? isEnabled(String id) {
    if (enabledStatus[id] == null) {
      enabledStatus[id] = false;
    }
    return enabledStatus[id];
  }

  void updateEnabledStatus(String id, bool change) {
    enabledStatus[id] = change;
  }

  bool isFormValid() {
    bool isValid = true;
    validations.forEach((key, value) {
      isValid = isValid && value;
    });
    return isValid;
  }

  void focusOnNextInvalid() {
    for (String key in validations.keys) {
      if (validations[key] == false) {
        FocusNode? invalidNode = getFocusNode(key);

        if (invalidNode != null) invalidNode.requestFocus();
        break;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    authController = Get.find<AuthController>();
    textControllers = <String, TextEditingController>{};
    focusNodes = <String, FocusNode>{};
    validations = <String, bool>{};
    enabledStatus = <String, bool>{};
  }

  @override
  void onClose() {
    textControllers.forEach((key, value) {
      value.dispose();
    });

    focusNodes.forEach((key, value) {
      value.dispose();
    });
    super.onClose();
  }

  // UI logic modules

  // ? Email Field methods
  String? signInEmailTextFieldValidation(String? value) {
    String? checkValue = value?.removeAllWhitespace;
    if (checkValue == null || checkValue.isEmpty) {
      updateValidation(signInEmailTextField, false);
    } else {
      updateValidation(signInEmailTextField, true);
    }

    return getValidation(signInEmailTextField)
        ? null
        : 'Please Enter Valid Email';
  }

  // ? password field methods
  bool isPasswordVisible() => _passwordVisible;

  void togglePasswordVisibleState() {
    _passwordVisible = !_passwordVisible;
    update([signInPasswordField]);
  }

  String? signInPasswordFieldValidation(String? value) {
    String? checkValue = value?.removeAllWhitespace;
    if (checkValue == null || checkValue.isEmpty || !(checkValue.length > 5)) {
      updateValidation(signInPasswordField, false);
    } else {
      updateValidation(signInPasswordField, true);
    }

    return getValidation(signInPasswordField)
        ? null
        : 'Password needs to be at least 6 characters';
  }

  // ? sign in button methods
  Future<void> signInAction(BuildContext context) async {
    final authResult = await authController.signIn(
        textControllers[signInEmailTextField]!.text.trim(),
        textControllers[signInPasswordField]!.text.trim());

    if (authResult == null) {
    } else {}
  }
}

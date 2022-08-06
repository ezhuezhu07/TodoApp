import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/models/todo_model.dart';

class EditTodoController extends GetxController {
  final String editTodoController = 'editTodoController';
  final String editPageTitle = 'editPageTitle';
  final String editTodoTypeIcon = 'editTodoTypeIcon';
  final String editTodoTypeList = 'editTodoTypeList';
  final String editTodoTitleTextField = 'editTodoTitleTextField';
  final String editTodoDescriptionTextArea = 'editTodoDescriptionTextArea';
  final String editTodoRemainderTime = 'editTodoRemainderTime';
  final String editTodoFormSubmitButton = 'editTodoFormSubmitButton';

  bool isUpdatePage = true;
  bool isDateSelected = false;
  late TodoModel todoModel;

  DateTime date = DateTime.now();
  //drop down
  String currentDropDownValue = 'Planning'; //present value of the dropdown
  List<String> dropDownValues = AppConst.labelIcons.keys.toList();

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

  // ? title Field methods
  String? editTodoTitleTextFieldValidation(String? value) {
    String? checkValue = value?.removeAllWhitespace;
    if (checkValue == null || checkValue.isEmpty) {
      updateValidation(editTodoTitleTextField, false);
    } else {
      updateValidation(editTodoTitleTextField, true);
    }

    return getValidation(editTodoTitleTextField)
        ? null
        : 'Please Enter Valid Title';
  }

  // ? Description field method
  String? editTodoDescriptionTextAreaValidation(String? value) {
    String? checkValue = value?.removeAllWhitespace;
    if (checkValue == null || checkValue.isEmpty) {
      updateValidation(editTodoDescriptionTextArea, false);
    } else {
      updateValidation(editTodoDescriptionTextArea, true);
    }

    return getValidation(editTodoTitleTextField)
        ? null
        : 'Please write description for todo';
  }

  // ? drop down change logic
  void dropDownChange(String? newValue) {
    if (newValue != null) {
      currentDropDownValue = newValue;
    }
    update([editTodoTypeList, editTodoTypeIcon]);
    // Todo logic for drop down change
  }

  Future<void> updateTodo(String id) async {
    TodoModel todoModel = TodoModel(
        title: getTextController(editTodoTitleTextField)!.text.trim(),
        description:
            getTextController(editTodoDescriptionTextArea)!.text.trim(),
        label: currentDropDownValue,
        date: date,
        createdTime: id);
    final docUpdate = FirebaseFirestore.instance
        .collection(AppConst.todoDatabaseName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConst.todoUserDatabaseName)
        .doc(todoModel.createdTime.toString());
    docUpdate.update(todoModel.toJson());
    Get.find<TodoDashboardController>().update();
    Get.snackbar(
      'Update Data Operation Status',
      'Data updated successfully',
      dismissDirection: DismissDirection.down,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

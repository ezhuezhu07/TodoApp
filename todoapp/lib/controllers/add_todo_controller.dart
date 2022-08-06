import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/models/todo_model.dart';

class AddTodoController extends GetxController {
  final String addTodoController = 'addTodoController';
  final String addPageTitle = 'addPageTitle';
  final String addTodoTypeIcon = 'addTodoTypeIcon';
  final String addTodoTypeList = 'addTodoTypeList';
  final String addTodoTitleTextField = 'addTodoTitleTextField';
  final String addTodoDescriptionTextArea = 'addTodoDescriptionTextArea';
  final String addTodoRemainderTime = 'addTodoRemainderTime';
  final String addTodoFormSubmitButton = 'addTodoFormSubmitButton';

  bool isDateSelected = false;

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
  String? addTodoTitleTextFieldValidation(String? value) {
    String? checkValue = value?.removeAllWhitespace;
    if (checkValue == null || checkValue.isEmpty) {
      updateValidation(addTodoTitleTextField, false);
    } else {
      updateValidation(addTodoTitleTextField, true);
    }

    return getValidation(addTodoTitleTextField)
        ? null
        : 'Please Enter Valid Title';
  }

  // ? Description field method
  String? addTodoDescriptionTextAreaValidation(String? value) {
    String? checkValue = value?.removeAllWhitespace;
    if (checkValue == null || checkValue.isEmpty) {
      updateValidation(addTodoDescriptionTextArea, false);
    } else {
      updateValidation(addTodoDescriptionTextArea, true);
    }

    return getValidation(addTodoTitleTextField)
        ? null
        : 'Please write description for todo';
  }

  // ? drop down change logic
  void dropDownChange(String? newValue) {
    if (newValue != null) {
      currentDropDownValue = newValue;
    }
    update([addTodoTypeList, addTodoTypeIcon]);
    // Todo logic for drop down change
  }

  Future<void> createTodo() async {
    print('date : $date');
    TodoModel todoModel = TodoModel(
        title: getTextController(addTodoTitleTextField)!.text.trim(),
        description: getTextController(addTodoDescriptionTextArea)!.text.trim(),
        label: currentDropDownValue,
        date: date,
        createdTime: DateTime.now().toString());
    await FirebaseFirestore.instance
        .collection(AppConst.todoDatabaseName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConst.todoUserDatabaseName)
        .doc(todoModel.createdTime.toString())
        .set(todoModel.toJson());
    await Get.find<TodoDashboardController>().initializeTodosCount();
    Get.find<TodoDashboardController>()
        .update([Get.find<TodoDashboardController>().todoListView]);
    Get.snackbar(
      'Add Data Operation Status',
      'Data added successfully',
      dismissDirection: DismissDirection.down,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

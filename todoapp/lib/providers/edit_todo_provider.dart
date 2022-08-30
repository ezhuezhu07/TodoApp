import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';

class EditTodoProvider extends ChangeNotifier {
  final String editTodoController = 'editTodoController';
  final String editPageTitle = 'editPageTitle';
  final String editTodoTypeIcon = 'editTodoTypeIcon';
  final String editTodoTypeList = 'editTodoTypeList';
  final String editTodoTitleTextField = 'editTodoTitleTextField';
  final String editTodoDescriptionTextArea = 'editTodoDescriptionTextArea';
  final String editTodoRemainderTime = 'editTodoRemainderTime';
  final String editTodoFormSubmitButton = 'editTodoFormSubmitButton';

  TodoModel? _todoModelData;

  bool _isUpdatePage = false;

  bool _isDateSelected = false;

  DateTime _date = DateTime.now();
  //drop down
  String _currentDropDownValue = 'Planning';
  //present value of the dropdown
  List<String> dropDownValues = AppConst.labelIcons.keys.toList();

  Map<String, TextEditingController> textControllers =
      <String, TextEditingController>{}; //map of all fields controllers

  Map<String, FocusNode> focusNodes =
      <String, FocusNode>{}; //map of all fields focus nodes

  Map<String, bool> validations =
      <String, bool>{}; //map of all fields validation status

  Map<String, bool> enabledStatus =
      <String, bool>{}; //map of all enabled fields status
  // TextField validation functions

  // getters
  bool get isDateSelected => _isDateSelected;

  bool get isUpdatePage => _isUpdatePage;

  DateTime get date => _date;

  String get currentDropDownValue => _currentDropDownValue;

  TodoModel get todoModelData => _todoModelData!;

  // setters
  void setTodoModelData(TodoModel model) {
    print('adding edit todo model');

    _todoModelData = model;
    notifyListeners();
  }

  void setIsDateSelected(bool value) {
    _isDateSelected = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    // _todoModelData!.date = value;
    _date = value;
    notifyListeners();
  }

  void setIsUpdatePage(bool value) {
    _isUpdatePage = value;
    notifyListeners();
  }

  void setCurrentDropDownValue(String value) {
    _todoModelData!.label = value;
    _currentDropDownValue = value;
    notifyListeners();
  }

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
    validations.putIfAbsent(id, () => true);
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
    // notifyListeners();
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
      print('key $key valid: $value');
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
    notifyListeners();
  }

  @override
  void onInit() {
    // super.onInit();
  }

  @override
  void onClose() {
    textControllers.forEach((key, value) {
      value.dispose();
    });

    focusNodes.forEach((key, value) {
      value.dispose();
    });
    // super.onClose();
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

    return getValidation(editTodoDescriptionTextArea)
        ? null
        : 'Please write description for todo';
  }

  // ? drop down change logic
  void dropDownChange(String? newValue) {
    if (newValue != null) {
      _currentDropDownValue = newValue;
    }
    notifyListeners();
    // Todo logic for drop down change
  }

  Future<bool> updateTodo(TodoModel model, BuildContext context) async {
    model.title = getTextController(editTodoTitleTextField)!.text.trim();
    model.description =
        getTextController(editTodoDescriptionTextArea)!.text.trim();
    // print(model.toJson());
    try {
      final docUpdate = FirebaseFirestore.instance
          .collection(AppConst.todoDatabaseName)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(AppConst.todoUserDatabaseName)
          .doc(model.createdTime.toString());
      docUpdate.update(model.toJson()).then((value) async {
        await Provider.of<TodoDashboardProvider>(context, listen: false)
            .initializeTodosCount();
        return true;
      });

      return true;
    } catch (onError) {
      return false;
    }
    // return false;
  }

  Future<void> showDatePickerWidget(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(date.year, date.month, date.day - 14),
        lastDate: DateTime(date.year, date.month, date.day + 14));
    if (newDate == null) return;
    setDate(newDate);
    setIsDateSelected(true);
  }
}

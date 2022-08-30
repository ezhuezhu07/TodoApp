import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';

class AddTodoProvider extends ChangeNotifier {
  final String addTodoController = 'addTodoController';
  final String addPageTitle = 'addPageTitle';
  final String addTodoTypeIcon = 'addTodoTypeIcon';
  final String addTodoTypeList = 'addTodoTypeList';
  final String addTodoTitleTextField = 'addTodoTitleTextField';
  final String addTodoDescriptionTextArea = 'addTodoDescriptionTextArea';
  final String addTodoRemainderTime = 'addTodoRemainderTime';
  final String addTodoFormSubmitButton = 'addTodoFormSubmitButton';
  final String addTodoDropDownMenu = 'addTodoDropDownMenu';
  OverlayState? overlayState = OverlayState();
  OverlayEntry? taskStatusOverlay;

  bool _isDateSelected = false;

  bool _showTaskDoneAnimation = false;

  DateTime _date = DateTime.now();
  //drop down
  String currentDropDownValue = 'Planning'; //present value of the dropdown
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
  TextEditingController? getTextController(String id) {
    return textControllers[id];
  }

  // getters
  bool get isDateSelected => _isDateSelected;

  DateTime get date => _date;

  bool get showTaskDoneAnimation => _showTaskDoneAnimation;

  // setters

  void setIsDateSelected(bool value) {
    _isDateSelected = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  void setShowTaskDoneAnimation(value) {
    _showTaskDoneAnimation = value;
    notifyListeners();
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
  String? addTodoTitleTextFieldValidation(String? value) {
    String? checkValue = value?.trim();
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
    String? checkValue = value?.trim();
    if (checkValue == null || checkValue.isEmpty) {
      updateValidation(addTodoDescriptionTextArea, false);
    } else {
      updateValidation(addTodoDescriptionTextArea, true);
    }

    return getValidation(addTodoDescriptionTextArea)
        ? null
        : 'Please write description for todo';
  }

  // ? drop down change logic
  void dropDownChange(String? newValue) {
    if (newValue != null) {
      currentDropDownValue = newValue;
    }
    notifyListeners();
    // update([addTodoTypeList, addTodoTypeIcon]);
    // Todo logic for drop down change
  }

  Future<bool> createTodo(BuildContext context) async {
    print('date : $date');
    try {
      TodoModel todoModel = TodoModel(
          title: getTextController(addTodoTitleTextField)!.text.trim(),
          description:
              getTextController(addTodoDescriptionTextArea)!.text.trim(),
          label: currentDropDownValue,
          date: date,
          isCompleted: false,
          createdTime: DateTime.now().toString());
      await FirebaseFirestore.instance
          .collection(AppConst.todoDatabaseName)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(AppConst.todoUserDatabaseName)
          .doc(todoModel.createdTime.toString())
          .set(todoModel.toJson())
          .then((value) async {
        print('create todo added successfully');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: navbarcolor,
          content: Text(
            'Created Todos added successfully',
            style: TextStyle(
              color: blueShade,
              fontSize: 18,
            ),
          ),
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.down,
        ));
        await Provider.of<TodoDashboardProvider>(context, listen: false)
            .initializeTodosCount();
        return true;
      }).catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: navbarcolor,
          content: Text(
            '$onError',
            style: const TextStyle(
              color: blueShade,
              fontSize: 18,
            ),
          ),
          duration: const Duration(seconds: 2),
          dismissDirection: DismissDirection.down,
        ));
      });

      // setShowTaskDoneAnimation(true);
      // Future.delayed(const Duration(seconds: 2));
      // setShowTaskDoneAnimation(false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: navbarcolor,
        content: Text(
          '$e',
          style: const TextStyle(
            color: blueShade,
            fontSize: 18,
          ),
        ),
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.down,
      ));
      return false;
    }
    return false;
    // await Get.find<TodoDashboardController>().initializeTodosCount();
    // Get.find<TodoDashboardController>()
    //     .update([Get.find<TodoDashboardController>().todoListView]);
    // Get.snackbar(
    //   'Add Data Operation Status',
    //   'Data added successfully',
    //   dismissDirection: DismissDirection.down,
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    // notifyListeners();
  }

  Future<void> showDatePickerWidget(BuildContext context) async {
    print('building date picker');
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(date.year, date.month, date.day - 14),
        lastDate: DateTime(date.year, date.month, date.day + 14));
    if (newDate == null) return;
    setDate(newDate);
    setIsDateSelected(true);
  }

  // showStatusOverlay(BuildContext context, SizeProvider sizeProvider) {
  //   overlayState = Overlay.of(context);
  //   taskStatusOverlay = OverlayEntry(builder: (context) {
  //     return Container(
  //         height: sizeProvider.screenHeight,
  //         width: sizeProvider.screenWidth,
  //         color: darkmgray,
  //         child: Center(child: Lottie.asset('assets/task_done.json')));
  //   });
  //   overlayState!.insert(taskStatusOverlay!);
  //   Future.delayed(const Duration(seconds: 2));
  //   taskStatusOverlay!.remove();
  // }

  // showStatusOverlay(BuildContext context) {
  //   // Center(child: Lottie.asset('assets/lottie_todo.json'))
  // }
}

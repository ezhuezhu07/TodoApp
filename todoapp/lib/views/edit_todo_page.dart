// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/controllers/edit_todo_controller.dart';
import 'package:todoapp/controllers/size_controller.dart';
import 'package:todoapp/models/todo_model.dart';

class EditTodoPage extends StatelessWidget {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // Sizes are assigned based on Screen Size
    SizeController sizeController = Get.put(SizeController());
    sizeController.setSize(context);
    print('Passed data');
    print(data);
    EditTodoController controller = Get.put(EditTodoController());
    if (data == null) {
      Get.back();
    }
    if (controller.isUpdatePage) {
      // controller.onInit();
      controller.todoModel = data[0] as TodoModel;

      controller.currentDropDownValue = controller.todoModel.label;
      controller.addTextController(controller.editTodoTitleTextField,
          initialValue: controller.todoModel.title);

      controller.addTextController(controller.editTodoDescriptionTextArea,
          initialValue: controller.todoModel.description);
      controller.date = controller.todoModel.date;
      controller.isUpdatePage = false;
      controller.update([controller.editTodoController]);
    }
    return GetBuilder<EditTodoController>(
      id: 'editTodoController',
      // init: EditTodoController(),
      builder: (controller) {
        // sizeController.setSize(context);
        return Material(
          child: Container(
            height: sizeController.screenHeight,
            width: sizeController.screenWidth,
            color: darkmgray,
            child: Stack(children: [
              Positioned(
                top: sizeController.screenHeight * 0.05,
                left: sizeController.screenWidth * 0.05,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: GestureDetector(
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: blueShade,
                          size: sizeController.fontSize3,
                        ),
                        onTap: () {
                          {
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: sizeController.addPageTitleTop,
                  left: sizeController.addPageTitleLeft,
                  child: SizedBox(
                    height: sizeController.addPageTitleHeight,
                    width: sizeController.addPageTitleWidth,
                    child: Center(
                        child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Update the thing',
                        style: TextStyle(
                          color: blueShade,
                          fontSize: sizeController.fontSize1,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  )),
              GetBuilder<EditTodoController>(
                init: EditTodoController(),
                id: 'editTodoTypeIcon',
                builder: (_) {
                  return Positioned(
                      top: sizeController.editTodoTypeIconTop,
                      left: sizeController.editTodoTypeIconLeft,
                      child: SizedBox(
                          height: sizeController.editTodoTypeIconHeight,
                          width: sizeController.editTodoTypeIconWidth,
                          child: CircleAvatar(
                            radius: sizeController.fontSize5,
                            backgroundColor: darkmpurple,
                            child: Icon(
                              AppConst
                                  .labelIcons[controller.currentDropDownValue],
                              size: sizeController.fontSize1,
                            ),
                          )));
                },
              ),
              Positioned(
                  top: sizeController.editTodoTypeListTop,
                  left: sizeController.editTodoTypeListLeft,
                  child: SizedBox(
                    height: sizeController.editTodoTypeListHeight,
                    width: sizeController.editTodoTypeListWidth,

                    //drop down item widget below
                    child: GetBuilder<EditTodoController>(
                        id: controller.editTodoTypeList,
                        builder: (EditTodoController dropDownController) {
                          //note tbd all dimensioning of text etc needs to be exposed as options to be passed on
                          //for the widget, this has not been done for this example

                          return DropdownButtonFormField<String>(
                            //focusNode: controller.addFocusNode(controller.dropdownid1uid),
                            value: controller.currentDropDownValue,
                            elevation: 16,
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                            ),
                            style: TextStyle(
                              // fontSize: sizeController.screenHeight * 0.033,
                              color: blueShade,
                            ),
                            dropdownColor: darkmgray,

                            onChanged: (String? newValue) {
                              if (newValue != controller.currentDropDownValue) {
                                controller.dropDownChange(newValue);
                              }
                            },

                            items: controller.dropDownValues
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                    width: sizeController.screenWidth * 0.8,
                                    child: Text(value,
                                        textAlign: TextAlign.center)),
                              );
                            }).toList(),
                          );
                        }),
                  )),
              Positioned(
                  top: sizeController.editTodoTitleTextFieldTop,
                  left: sizeController.editTodoTitleTextFieldLeft,
                  child: SizedBox(
                      height: sizeController.editTodoTitleTextFieldHeight,
                      width: sizeController.editTodoTitleTextFieldWidth,
                      child: TextFormField(
                        controller: controller.addTextController(
                            controller.editTodoTitleTextField,
                            initialValue: ""),
                        focusNode: controller
                            .addFocusNode(controller.editTodoTitleTextField),

                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        validator: (String? value) {
                          return controller
                              .editTodoTitleTextFieldValidation(value);
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
                          labelText: 'Title',
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
                  top: sizeController.editTodoDescriptionTextAreaTop,
                  left: sizeController.editTodoDescriptionTextAreaLeft,
                  child: GetBuilder<EditTodoController>(
                    id: controller.editTodoDescriptionTextArea,
                    builder: (_) {
                      return SizedBox(
                          height:
                              sizeController.editTodoDescriptionTextAreaHeight,
                          width:
                              sizeController.editTodoDescriptionTextAreaWidth,
                          child: TextFormField(
                            // readOnly: controller.isSignInRequesting,
                            controller: controller.addTextController(
                                controller.editTodoDescriptionTextArea,
                                initialValue: ""),
                            focusNode: controller.addFocusNode(
                                controller.editTodoDescriptionTextArea),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            onSaved: (String? value) {},
                            validator: (String? value) {
                              return controller
                                  .editTodoDescriptionTextAreaValidation(value);
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

                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                              labelText: 'Description',
                              labelStyle: (TextStyle(
                                  fontSize: sizeController.fontSize4,
                                  color: bluemid,
                                  fontWeight: FontWeight.normal)),
                              errorStyle: (TextStyle(
                                  fontSize: sizeController.fontSize5,
                                  color: Colors.red,
                                  fontWeight: FontWeight.normal)),
                            ),
                          ));
                    },
                  )),
              Positioned(
                  top: sizeController.editTodoRemainderTimeTop,
                  left: sizeController.editTodoRemainderTimeLeft,
                  child: GetBuilder<EditTodoController>(
                    id: controller.editTodoRemainderTime,
                    builder: (_) {
                      return SizedBox(
                        height: sizeController.editTodoRemainderTimeHeight,
                        width: sizeController.editTodoRemainderTimeWidth,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        controller.isDateSelected
                                            ? darkmgray
                                            : blueShadeLight),
                                // shadowColor: MaterialStateProperty.all<Color>(
                                //     Colors.black),
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
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: controller.date,
                                  firstDate: DateTime(
                                      controller.date.year,
                                      controller.date.month,
                                      controller.date.day - 14),
                                  lastDate: DateTime(
                                      controller.date.year,
                                      controller.date.month,
                                      controller.date.day + 14));
                              if (newDate == null) return;
                              controller.date = newDate;
                              controller.isDateSelected = true;
                              controller
                                  .update([controller.editTodoRemainderTime]);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                DateFormat('dd-MMM-yyyy')
                                    .format(_.date)
                                    .toString(),
                                style: TextStyle(
                                  fontSize: sizeController.fontSize4,
                                ),
                              ),
                            )),
                      );
                    },
                  )),
              Positioned(
                top: sizeController.editTodoFormSubmitButtonTop,
                left: sizeController.editTodoFormSubmitButtonLeft,
                child: SizedBox(
                  height: sizeController.editTodoFormSubmitButtonHeight,
                  width: sizeController.editTodoFormSubmitButtonWidth,
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
                      if (controller.isFormValid()) {
                        await controller
                            .updateTodo(controller.todoModel.createdTime);
                        // Get.back();
                      } else {
                        controller.focusOnNextInvalid();
                      }
                      // Todo logic for add and update data in firebase
                     
                      // controller.isUpdatePage?
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: sizeController.fontSize4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
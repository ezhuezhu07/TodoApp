// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/edit_todo_provider.dart';
import 'package:todoapp/providers/size_providers.dart';

class EditTodoPage extends StatelessWidget {
  TodoModel todoModel;
  EditTodoPage({super.key, required this.todoModel}) {
    todoModel = todoModel;
  }
  @override
  Widget build(BuildContext context) {
    SizeProvider sizer = Provider.of<SizeProvider>(context, listen: false);
    // final edittodoprovider1 =
    //     Provider.of<EditTodoProvider>(context, listen: false);
    return ChangeNotifierProvider<EditTodoProvider>(
      create: (context) => EditTodoProvider(),
      // sizer.setSize(context);
      child: Material(
        child: Scaffold(
          body: Container(
            height: sizer.screenHeight,
            width: sizer.screenWidth,
            color: uiBcakgroundColor,
            child: Stack(children: [
              Positioned(
                top: sizer.screenHeight * 0.05,
                left: sizer.screenWidth * 0.05,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: GestureDetector(
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: uiWhiteColor,
                          size: sizer.fontSize5 * 1.25,
                        ),
                        onTap: () {
                          {
                            // Get.back();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: sizer.addPageTitleTop,
                  left: sizer.addPageTitleLeft,
                  child: SizedBox(
                    height: sizer.addPageTitleHeight,
                    width: sizer.addPageTitleWidth,
                    child: Center(
                        child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Update the thing',
                        style: TextStyle(
                            color: uiWhiteColor,
                            fontSize: sizer.fontSize3,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rozanova_Medium'),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  )),
              Consumer<EditTodoProvider>(
                builder: (context, editTodoProvider, child) {
                  return Positioned(
                      top: sizer.editTodoTypeIconTop,
                      left: sizer.editTodoTypeIconLeft,
                      child: SizedBox(
                          // height: sizer.editTodoTypeIconHeight,
                          // width: sizer.editTodoTypeIconWidth,
                          child: CircleAvatar(
                        backgroundColor: gray,
                        radius: sizer.fontSize3 * 1.075,
                        child: CircleAvatar(
                          radius: sizer.fontSize3,
                          backgroundColor: uiBcakgroundColor,
                          child: Icon(
                            AppConst.labelIcons[
                                // editTodoProvider.isUpdatePage
                                // editTodoProvider.currentDropDownValue
                                todoModel.label
                                // editTodoProvider.todoModelData.label
                                ],
                            color: uiButtonColor,
                            size: sizer.fontSize3,
                          ),
                        ),
                      )));
                },
              ),
              Positioned(
                  top: sizer.editTodoTypeListTop,
                  left: sizer.editTodoTypeListLeft,
                  child: SizedBox(
                    height: sizer.editTodoTypeListHeight * 1.5,
                    width: sizer.editTodoTypeListWidth,

                    //drop down item widget below
                    child: Consumer<EditTodoProvider>(
                        builder: (context, editTodoProvider, child) {
                      return DropdownButtonFormField<String>(
                        //focusNode: editTodoProvider.addFocusNode(editTodoProvider.dropdownid1uid),

                        value: todoModel.label,
                        elevation: 16,
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: gray)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: gray)),
                        ),
                        style: TextStyle(
                          fontFamily: 'Rozanova_Medium',
                          fontSize: sizer.fontSize5 * 1.25,
                          color: uiWhiteColor,
                        ),
                        dropdownColor: uiBcakgroundColor,

                        onChanged: (String? newValue) {
                          if (newValue !=
                              Provider.of<EditTodoProvider>(context,
                                      listen: false)
                                  .currentDropDownValue) {
                            todoModel.label = newValue!;
                            Provider.of<EditTodoProvider>(context,
                                    listen: false)
                                .dropDownChange(newValue);
                          }
                        },

                        items: editTodoProvider.dropDownValues
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                                height: sizer.screenHeight * 0.05,
                                width: sizer.screenWidth * 0.8,
                                child:
                                    Text(value, textAlign: TextAlign.center)),
                          );
                        }).toList(),
                      );
                    }),
                  )),
              Consumer<EditTodoProvider>(
                  builder: (context, editTodoProvider, child) {
                return Positioned(
                    top: sizer.editTodoTitleTextFieldTop,
                    left: sizer.editTodoTitleTextFieldLeft,
                    child: SizedBox(
                        height: sizer.editTodoTitleTextFieldHeight,
                        width: sizer.editTodoTitleTextFieldWidth,
                        child: TextFormField(
                          controller: editTodoProvider.addTextController(
                              editTodoProvider.editTodoTitleTextField,
                              initialValue: todoModel.title),
                          focusNode: Provider.of<EditTodoProvider>(context,
                                  listen: false)
                              .addFocusNode(Provider.of<EditTodoProvider>(
                                      context,
                                      listen: false)
                                  .editTodoTitleTextField),

                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator: (String? value) {
                            return Provider.of<EditTodoProvider>(context,
                                    listen: false)
                                .editTodoTitleTextFieldValidation(value);
                          },
                          textAlign: TextAlign.center,
                          onChanged: (value) {},

                          style: (TextStyle(
                              fontSize: sizer.fontSize3 * 0.75,
                              color: uiWhiteColor,
                              fontFamily: 'Rozanova_Medium',
                              fontWeight: FontWeight.normal)),
                          //more options below, uncomment to activate

                          keyboardType: TextInputType.emailAddress,
                          // cursorColor: ,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: gray,
                              // color: addTodoProvider.fgIconColor
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gray)),
                            labelText: 'Title',
                            labelStyle: (TextStyle(
                                fontSize: sizer.fontSize5 * 1.25,
                                fontFamily: 'Rozanova_Medium',
                                color: uiWhiteColor,
                                fontWeight: FontWeight.normal)),
                            errorStyle: (TextStyle(
                                fontSize: sizer.fontSize5,
                                color: cherry,
                                fontFamily: 'Rozanova_Medium',
                                fontWeight: FontWeight.normal)),
                          ),
                          //cursorHeight: screensize.height*0.05,
                        )));
              }),
              Positioned(
                  top: sizer.editTodoDescriptionTextAreaTop,
                  left: sizer.editTodoDescriptionTextAreaLeft,
                  child: Consumer<EditTodoProvider>(
                    builder: (context, editTodoProvider, child) {
                      return SizedBox(
                          height: sizer.editTodoDescriptionTextAreaHeight,
                          width: sizer.editTodoDescriptionTextAreaWidth,
                          child: TextFormField(
                            minLines: 3,
                            maxLines: 6,
                            // readOnly: editTodoProvider.isSignInRequesting,
                            controller: editTodoProvider.addTextController(
                                editTodoProvider.editTodoDescriptionTextArea,
                                initialValue: todoModel.description),
                            focusNode: Provider.of<EditTodoProvider>(context,
                                    listen: false)
                                .addFocusNode(Provider.of<EditTodoProvider>(
                                        context,
                                        listen: false)
                                    .editTodoDescriptionTextArea),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            onSaved: (String? value) {},
                            validator: (String? value) {
                              return Provider.of<EditTodoProvider>(context,
                                      listen: false)
                                  .editTodoDescriptionTextAreaValidation(value);
                            },

                            textAlign: TextAlign.center,
                            onChanged: (value) {},

                            //All textfield options have to be made as properties of textfield widget
                            style: (TextStyle(
                              fontSize: sizer.fontSize5 * 1.25,
                              color: uiWhiteColor,
                              fontFamily: 'Rozanova_Medium',
                            )),
                            keyboardType: TextInputType.text,
                            cursorColor: uiWhiteColor,

                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: gray)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: gray)),
                              labelText: 'Description',
                              labelStyle: (TextStyle(
                                  fontSize: sizer.fontSize5 * 1.25,
                                  fontFamily: 'Rozanova_Medium',
                                  color: uiWhiteColor,
                                  fontWeight: FontWeight.normal)),
                              errorStyle: (TextStyle(
                                  fontSize: sizer.fontSize5,
                                  fontFamily: 'Rozanova_Medium',
                                  color: Colors.red,
                                  fontWeight: FontWeight.normal)),
                            ),
                          ));
                    },
                  )),
              Positioned(
                  top: sizer.editTodoRemainderTimeTop,
                  left: sizer.editTodoRemainderTimeLeft,
                  child: Consumer<EditTodoProvider>(
                    builder: (context, editTodoProvider, child) {
                      return SizedBox(
                        height: sizer.editTodoRemainderTimeHeight,
                        width: sizer.editTodoRemainderTimeWidth,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Provider.of<EditTodoProvider>(context,
                                                    listen: false)
                                                .isDateSelected
                                            ? uiBcakgroundColor
                                            : uiBcakgroundColor),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return uiBcakgroundColor;
                                  }
                                  if (states.contains(MaterialState.pressed)) {
                                    return uiBcakgroundColor;
                                  }
                                  return null; // Defer to the widget's default.
                                })),
                            onPressed: () async {
                              await Provider.of<EditTodoProvider>(context,
                                      listen: false)
                                  .showDatePickerWidget(context);
                              todoModel.date = editTodoProvider.date;
                              // if (!edittodoprovider1.isUpdatePage) {
                              //   edittodoprovider1
                              //       .setCurrentDropDownValue(todoModel.label);
                              //   edittodoprovider1.setIsUpdatePage(true);
                              // }
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                DateFormat('dd-MMM-yyyy').format(
                                    // editTodoProvider.isUpdatePage
                                    // editTodoProvider.date
                                    todoModel.date).toString(),
                                style: TextStyle(
                                  fontFamily: 'Sans-Serif',
                                  color: uiWhiteColor,
                                  fontSize: sizer.fontSize5 * 1.25,
                                ),
                              ),
                            )),
                      );
                    },
                  )),
              Positioned(
                top: sizer.editTodoFormSubmitButtonTop,
                left: sizer.editTodoFormSubmitButtonLeft,
                child: SizedBox(
                  height: sizer.editTodoFormSubmitButtonHeight * 1.25,
                  width: sizer.editTodoFormSubmitButtonWidth,
                  child: Consumer<EditTodoProvider>(
                      builder: (context, editTodoProvider, child) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(uiButtonColor),
                      ),
                      onPressed: () async {
                        if (Provider.of<EditTodoProvider>(context,
                                listen: false)
                            .isFormValid()) {
                          bool status = await Provider.of<EditTodoProvider>(
                                  context,
                                  listen: false)
                              .updateTodo(todoModel, context);
                          if (status) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: uiBcakgroundColor,
                              content: Text(
                                'Todos Updated successfully',
                                style: TextStyle(
                                  color: uiWhiteColor,
                                  fontSize: 18,
                                ),
                              ),
                              duration: Duration(seconds: 2),
                              dismissDirection: DismissDirection.down,
                            ));
                          }
                        } else {
                          Provider.of<EditTodoProvider>(context, listen: false)
                              .focusOnNextInvalid();
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontFamily: 'Rozanova_Medium',
                            fontSize: sizer.fontSize5 * 1.25,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

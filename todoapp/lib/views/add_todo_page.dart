// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/providers/add_todo_provider.dart';
import 'package:todoapp/providers/size_providers.dart';

class AddTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeProvider sizer = Provider.of<SizeProvider>(context, listen: false);

    // ;

    return ChangeNotifierProvider<AddTodoProvider>(
      create: (context) => AddTodoProvider(),
      child: Material(
        child: Scaffold(
          body: Container(
            height: sizer.screenHeight,
            width: sizer.screenWidth,
            color: darkmgray,
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
                          color: blueShade,
                          size: sizer.fontSize3,
                        ),
                        onTap: () {
                          {
                            // Provider.of<TodoDashboardProvider>(context,
                            //         listen: false)
                            //     .addTodoOverlay!
                            //     .remove();
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
                        'Add new thing',
                        style: TextStyle(
                          color: blueShade,
                          fontSize: sizer.fontSize1,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  )),
              Consumer<AddTodoProvider>(
                builder: (context, addTodoProvider, child) {
                  return Positioned(
                      top: sizer.addTodoTypeIconTop,
                      left: sizer.addTodoTypeIconLeft,
                      child: SizedBox(
                          height: sizer.addTodoTypeIconHeight,
                          width: sizer.addTodoTypeIconWidth,
                          child: CircleAvatar(
                            radius: sizer.fontSize5,
                            backgroundColor: darkmpurple,
                            child: Icon(
                              AppConst.labelIcons[
                                  addTodoProvider.currentDropDownValue],
                              size: sizer.fontSize1,
                            ),
                          )));
                },
              ),
              Positioned(
                  top: sizer.addTodoTypeListTop,
                  left: sizer.addTodoTypeListLeft,
                  child: SizedBox(
                    height: sizer.addTodoTypeListHeight * 1.5,
                    width: sizer.addTodoTypeListWidth,
                    //drop down item widget below
                    child: Consumer<AddTodoProvider>(
                      builder: (context, addTodoProvider, child) {
                        print('Building drop down');
                        return DropdownButtonFormField<String>(
                          // focusNode: addTodoProvider
                          //     .addFocusNode(addTodoProvider.addTodoDropDownMenu),
                          value: addTodoProvider.currentDropDownValue,
                          elevation: 16,
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: bluemid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bluemid)),
                          ),
                          style: TextStyle(
                            // fontSize: sizer.screenHeight * 0.033,
                            color: blueShade,
                          ),
                          dropdownColor: darkmgray,
                          onChanged: (String? newValue) {
                            if (newValue !=
                                Provider.of<AddTodoProvider>(context,
                                        listen: false)
                                    .currentDropDownValue) {
                              Provider.of<AddTodoProvider>(context,
                                      listen: false)
                                  .dropDownChange(newValue);
                            }
                          },
                          items: addTodoProvider.dropDownValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                  width: sizer.screenWidth * 0.8,
                                  child:
                                      Text(value, textAlign: TextAlign.center)),
                              //  Consumer<SizeProvider>(
                              //     builder: (context, sizeProvider, child) {
                              //   return

                              // }),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    // Consumer<AddTodoProvider>(
                    //     builder: (context, addTodoProvider, child) {
                    //       //note tbd all dimensioning of text etc needs to be exposed as options to be passed on
                    //       //for the widget, this has not been done for this example

                    //       return
                    //     }),
                  )),
              Consumer<AddTodoProvider>(
                builder: (context, addTodoProvider, child) {
                  return Positioned(
                      top: sizer.addTodoTitleTextFieldTop,
                      left: sizer.addTodoTitleTextFieldLeft,
                      child: SizedBox(
                          height: sizer.addTodoTitleTextFieldHeight,
                          width: sizer.addTodoTitleTextFieldWidth,
                          child: TextFormField(
                            controller: addTodoProvider.addTextController(
                                addTodoProvider.addTodoTitleTextField,
                                initialValue: ""),
                            focusNode: Provider.of<AddTodoProvider>(context,
                                    listen: false)
                                .addFocusNode(Provider.of<AddTodoProvider>(
                                        context,
                                        listen: false)
                                    .addTodoTitleTextField),

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            validator: (String? value) {
                              return addTodoProvider
                                  .addTodoTitleTextFieldValidation(value);
                            },
                            textAlign: TextAlign.center,
                            onChanged: (value) {},

                            style: (TextStyle(
                                fontSize: sizer.fontSize4,
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
                                // color: addTodoProvider.fgIconColor
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                              labelText: 'Title',
                              labelStyle: (TextStyle(
                                  fontSize: sizer.fontSize4,
                                  color: bluemid,
                                  fontWeight: FontWeight.normal)),
                              errorStyle: (TextStyle(
                                  fontSize: sizer.fontSize5,
                                  color: cherry,
                                  fontWeight: FontWeight.normal)),
                            ),
                            //cursorHeight: screensize.height*0.05,
                          )));
                },
              ),
              Consumer<AddTodoProvider>(
                builder: (context, addTodoProvider, child) {
                  return Positioned(
                      top: sizer.addTodoDescriptionTextAreaTop,
                      left: sizer.addTodoDescriptionTextAreaLeft,
                      child: SizedBox(
                          height: sizer.addTodoDescriptionTextAreaHeight,
                          width: sizer.addTodoDescriptionTextAreaWidth,
                          child: TextFormField(
                            // readOnly: addTodoProvider.isSignInRequesting,
                            minLines: 3,
                            maxLines: 6,
                            // keyboardType: TextInputType.multiline,
                            controller: Provider.of<AddTodoProvider>(context,
                                    listen: false)
                                .addTextController(
                                    Provider.of<AddTodoProvider>(context,
                                            listen: false)
                                        .addTodoDescriptionTextArea,
                                    initialValue: ""),
                            focusNode: Provider.of<AddTodoProvider>(context,
                                    listen: false)
                                .addFocusNode(Provider.of<AddTodoProvider>(
                                        context,
                                        listen: false)
                                    .addTodoDescriptionTextArea),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            onSaved: (String? value) {},
                            validator: (String? value) {
                              return Provider.of<AddTodoProvider>(context,
                                      listen: false)
                                  .addTodoDescriptionTextAreaValidation(value);
                            },

                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              //on change ULM here
                            },

                            //All textfield options have to be made as properties of textfield widget
                            style: (TextStyle(
                              fontSize: sizer.fontSize4,
                              color: blueShade,
                            )),
                            keyboardType: TextInputType.multiline,
                            cursorColor: blueShade,

                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluemid)),
                              labelText: 'Description',
                              labelStyle: (TextStyle(
                                  fontSize: sizer.fontSize4,
                                  color: bluemid,
                                  fontWeight: FontWeight.normal)),
                              errorStyle: (TextStyle(
                                  fontSize: sizer.fontSize5,
                                  color: Colors.red,
                                  fontWeight: FontWeight.normal)),
                            ),
                          ))
                      // Consumer<AddTodoProvider>(
                      //   builder: (context, addTodoProvider, child) {
                      //     return
                      //   },
                      // )
                      );
                },
              ),
              Positioned(
                top: sizer.addTodoRemainderTimeTop,
                left: sizer.addTodoRemainderTimeLeft,
                child: SizedBox(
                  height: sizer.addTodoRemainderTimeHeight,
                  width: sizer.addTodoRemainderTimeWidth,
                  child: Consumer<AddTodoProvider>(
                      builder: (context, addTodoProvider, child) {
                    return ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Provider.of<AddTodoProvider>(context,
                                          listen: false)
                                      .isDateSelected
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
                        await Provider.of<AddTodoProvider>(context,
                                listen: false)
                            .showDatePickerWidget(context);
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          addTodoProvider.isDateSelected
                              ? DateFormat('dd-MMM-yyyy')
                                  .format(addTodoProvider.date)
                                  .toString()
                              : 'Pick a date',
                          style: TextStyle(
                            fontSize: sizer.fontSize4,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                // Consumer<AddTodoProvider>(
                //   builder: (context, addTodoProvider, child) {
                //     return
                //   },
                // )
              ),
              Consumer<AddTodoProvider>(
                builder: (context, addTodoProvider, child) {
                  return Positioned(
                    top: sizer.addTodoFormSubmitButtonTop,
                    left: sizer.addTodoFormSubmitButtonLeft,
                    child: SizedBox(
                      height: sizer.addTodoFormSubmitButtonHeight,
                      width: sizer.addTodoFormSubmitButtonWidth,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                blueShadeLight),
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.black),
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
                          // Todo logic for add and update data in firebase
                          if (Provider.of<AddTodoProvider>(context,
                                      listen: false)
                                  .isFormValid() &&
                              Provider.of<AddTodoProvider>(context,
                                      listen: false)
                                  .isDateSelected) {
                            bool status = await Provider.of<AddTodoProvider>(
                                    context,
                                    listen: false)
                                .createTodo(context);
                            if (status) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: navbarcolor,
                                content: Text(
                                  'Todos added successfully',
                                  style: TextStyle(
                                    color: blueShade,
                                    fontSize: 18,
                                  ),
                                ),
                                duration: Duration(seconds: 2),
                                // dismissDirection: DismissDirection.down,
                              ));
                              // Navigator.pop(context);
                            }
                          } else {
                            Provider.of<AddTodoProvider>(context, listen: false)
                                .focusOnNextInvalid();
                          }
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: addTodoProvider.showTaskDoneAnimation
                              ? Center(
                                  child: Lottie.asset('assets/task_done.json'))
                              : Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: sizer.fontSize4,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

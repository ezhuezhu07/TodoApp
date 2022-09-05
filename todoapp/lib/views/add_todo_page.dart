// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                            color: uiWhiteColor,
                            fontSize: sizer.fontSize3,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rozanova_Medium'),
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
                          // height: sizer.addTodoTypeIconHeight,
                          // width: sizer.addTodoTypeIconWidth,
                          child: CircleAvatar(
                        backgroundColor: gray,
                        radius: sizer.fontSize3 * 1.075,
                        child: CircleAvatar(
                          radius: sizer.fontSize3,
                          backgroundColor: uiBcakgroundColor,
                          child: Icon(
                            AppConst.labelIcons[
                                addTodoProvider.currentDropDownValue],
                            color: uiButtonColor,
                            size: sizer.fontSize3,
                          ),
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
                                borderSide: BorderSide(color: gray)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gray)),
                          ),
                          style: TextStyle(
                            fontFamily: 'Rozanova_Medium',
                            fontSize: sizer.fontSize5 * 1.25,
                            // fontSize: sizer.screenHeight * 0.033,
                            color: uiWhiteColor,
                          ),
                          dropdownColor: uiBcakgroundColor,
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
                                  height: sizer.screenHeight * 0.05,
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
                                fontSize: sizer.fontSize3 * 0.75,
                                color: uiWhiteColor,
                                fontFamily: 'Rozanova_Medium',
                                fontWeight: FontWeight.normal)),
                            //more options below, uncomment to activate

                            keyboardType: TextInputType.emailAddress,
                            cursorColor: uiWhiteColor,
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
                              fontSize: sizer.fontSize5 * 1.25,
                              color: uiWhiteColor,
                              fontFamily: 'Rozanova_Medium',
                            )),
                            keyboardType: TextInputType.multiline,
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
                            fontFamily: addTodoProvider.isDateSelected
                                ? 'Sans-Serif'
                                : 'Rozanova_Medium',
                            color: uiWhiteColor,
                            fontSize: sizer.fontSize5 * 1.25,
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
                      height: sizer.addTodoFormSubmitButtonHeight * 1.25,
                      width: sizer.addTodoFormSubmitButtonWidth,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(uiButtonColor),
                        ),
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
                                  .showSnackBar(SnackBar(
                                backgroundColor: navbarcolor,
                                content: Text(
                                  'Todos added successfully',
                                  style: TextStyle(
                                    fontFamily: 'Rozanova_Medium',
                                    color: uiWhiteColor,
                                    fontSize: sizer.fontSize5 * 1.25,
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
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Rozanova_Medium',
                              fontSize: sizer.fontSize5 * 1.25,
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

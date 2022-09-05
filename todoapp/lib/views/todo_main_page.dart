// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/providers/size_providers.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';
import 'package:todoapp/views/add_todo_page.dart';
import 'package:todoapp/widgets/custom_page_route_animation.dart';
import 'package:todoapp/widgets/todo_inox_list_widget.dart';

class TodoMainPage extends StatelessWidget {
  // const TodoMainPage({Key? key}) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    Provider.of<SizeProvider>(context, listen: false).setSize(context);
    context.read<TodoDashboardProvider>().initializeTodosCount();
    return Consumer<SizeProvider>(builder: (context, sizeProvider, child) {
      return Scaffold(
        // drawer: NavigationDrawerWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRouteAnimation(child: AddTodoPage()),
            );
          },
          backgroundColor: uiButtonColor,
          child: const Icon(
            Icons.add,
            color: uiWhiteColor,
          ),
        ),
        body: Container(
          color: uiWhiteColor,
          height: sizeProvider.screenHeight,
          width: sizeProvider.screenWidth,
          child: Stack(
            children: [
              Positioned(
                  top: sizeProvider.todoMainPageTopViewTop,
                  left: sizeProvider.todoMainPageTopViewLeft,
                  child: Container(
                    height: sizeProvider.todoMainPageTopViewHeight,
                    width: sizeProvider.todoMainPageTopViewWidth,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Dashboard_bg.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      height: sizeProvider.todoMainPageTopViewHeight,
                      width: sizeProvider.todoMainPageTopViewWidth,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.pink.withOpacity(0.1),
                        Colors.pink.withOpacity(0.1),
                      ])),
                      child: Container(
                        height: sizeProvider.todoMainPageTopViewHeight,
                        width: sizeProvider.todoMainPageTopViewWidth,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Colors.pink.withOpacity(0.0),
                            Colors.black.withOpacity(0.2),
                          ],
                          stops: const [0.65, 0.35],
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height:
                                  sizeProvider.todoMainPageTopViewHeight * 0.95,
                              width: sizeProvider.todoMainPageListViewWidth,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: sizeProvider.screenWidth * 0.05,
                                  top: sizeProvider.todoMainPageTopViewHeight *
                                      0.05,
                                  right: sizeProvider.screenWidth * 0.025,
                                  bottom:
                                      sizeProvider.todoMainPageTopViewHeight *
                                          0.05,
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: IconButton(
                                        alignment: Alignment.topLeft,
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                        },
                                        iconSize: 24,
                                        color: uiWhiteColor,
                                        icon: const Icon(Icons.menu),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: sizeProvider
                                                    .todoMainPageListViewWidth *
                                                0.3,
                                            // color: Colors.blueGrey,
                                            child: const Text(
                                              'Your Things',
                                              style: TextStyle(
                                                  height: 1,
                                                  color: uiWhiteColor,
                                                  fontFamily: 'Rozanova_Medium',
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: sizeProvider
                                                    .todoMainPageTopViewWidth *
                                                0.3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Consumer<
                                                            TodoDashboardProvider>(
                                                        builder: (context,
                                                            provider, child) {
                                                      return Text(
                                                        '${provider.personalTodoCount}',
                                                        style: TextStyle(
                                                            color: uiWhiteColor,
                                                            fontFamily:
                                                                'Sans-Serif',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      );
                                                    }),
                                                    Text(
                                                      'Personal',
                                                      style: TextStyle(
                                                        color: uiWhiteColor,
                                                        fontFamily:
                                                            'Rozanova_Medium',
                                                        fontSize: sizeProvider
                                                            .fontSize5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Consumer<
                                                            TodoDashboardProvider>(
                                                        builder: (context,
                                                            provider, child) {
                                                      return Text(
                                                        '${provider.businessTodoCount}',
                                                        style: TextStyle(
                                                            color: uiWhiteColor,
                                                            fontFamily:
                                                                'Sans-Serif',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      );
                                                    }),
                                                    Text(
                                                      'Business',
                                                      style: TextStyle(
                                                        color: uiWhiteColor,
                                                        fontFamily:
                                                            'Rozanova_Medium',
                                                        fontSize: sizeProvider
                                                            .fontSize5,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Container(),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeProvider
                                                      .todoMainPageListViewWidth *
                                                  0.25,
                                              child: Text(
                                                DateFormat('dd MMM yyyy')
                                                    .format(DateTime.now()),
                                                style: TextStyle(
                                                  color: uiWhiteColor,
                                                  // fontFamily: 'Rozanova_Medium',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: sizeProvider
                                                      .todoMainPageListViewWidth *
                                                  0.35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Consumer<
                                                          TodoDashboardProvider>(
                                                      builder: (context,
                                                          provider, child) {
                                                    return CircularPercentIndicator(
                                                      radius: sizeProvider
                                                              .todoMainPageListViewWidth *
                                                          0.035,
                                                      lineWidth: (sizeProvider
                                                                  .todoMainPageListViewWidth *
                                                              0.035) /
                                                          5,
                                                      percent: (provider
                                                                  .totalTodosCount !=
                                                              0)
                                                          ? ((provider.totalTodosCount -
                                                                          provider
                                                                              .completedTodosCount) ==
                                                                      0
                                                                  ? 1
                                                                  : (provider
                                                                          .totalTodosCount -
                                                                      provider
                                                                          .completedTodosCount)) /
                                                              (provider
                                                                  .totalTodosCount)
                                                          : 0.0,
                                                      backgroundColor:
                                                          uiBcakgroundColor,
                                                      progressColor:
                                                          uiButtonColor,
                                                    );
                                                  }),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Consumer<
                                                          TodoDashboardProvider>(
                                                      builder: (context,
                                                          provider, child) {
                                                    return Text(
                                                      '${(provider.totalTodosCount != 0) ? (((provider.totalTodosCount - provider.completedTodosCount) == 0 ? 1 : (provider.totalTodosCount - provider.completedTodosCount)) / (provider.totalTodosCount) * 100).floor() : 0}% done',
                                                      style: TextStyle(
                                                        color: uiWhiteColor,
                                                        // fontFamily: 'Rozanova_Medium',
                                                        fontSize: sizeProvider
                                                            .fontSize5,
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: sizeProvider.todoMainPageTopViewHeight *
                                  0.025,
                              width: sizeProvider.todoMainPageTopViewWidth,
                              // ignore: prefer_const_constructors
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  stops: [0.3, 0.65],
                                  colors: [
                                    uiBcakgroundColor,
                                    uiButtonColor,
                                    // Colors.black
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: sizeProvider.todoMainPageListViewTop,
                  left: sizeProvider.todoMainPageListViewLeft,
                  height: sizeProvider.todoMainPageListViewHeight,
                  width: sizeProvider.todoMainPageListViewWidth,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: uiWhiteColor,
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INBOX',
                            style: TextStyle(color: graymid),
                          ),
                          TodoInboxList(complete: false),
                          Text(
                            'COMPLETED',
                            style: TextStyle(color: graymid),
                          ),
                          TodoInboxList(complete: true),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}

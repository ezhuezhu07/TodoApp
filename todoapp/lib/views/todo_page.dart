import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/providers/size_providers.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';
// import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/views/add_todo_page.dart';
import 'package:todoapp/widgets/card_widget.dart';
import 'package:todoapp/widgets/custom_page_route_animation.dart';
import 'package:todoapp/widgets/drawer_widget.dart';
import 'package:todoapp/widgets/todo_list_widget.dart';

class TodoDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SizeProvider>(context, listen: false).setSize(context);
    context.read<TodoDashboardProvider>().initializeTodosCount();
    return Consumer<SizeProvider>(builder: (context, sizeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkmgray,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Todo App",
              style: TextStyle(
                color: blueShade,
                fontSize: sizeProvider.fontSize1,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRouteAnimation(child: AddTodoPage()),
            );
          },
          backgroundColor: blueShadeLight,
          child: const Icon(
            Icons.add,
            color: blueShade,
          ),
        ),
        body: SizedBox(
          height: sizeProvider.screenHeight,
          width: sizeProvider.screenWidth,
          child: Stack(
            children: [
              Positioned(
                  top: sizeProvider.dashBoardTitleContainerTop,
                  left: sizeProvider.dashBoardTitleContainerLeft,
                  child: Container(
                    color: darkmgray,
                    height: sizeProvider.dashBoardTitleContainerHeight,
                    width: sizeProvider.dashBoardTitleContainerWidth,
                    child: GridTile(
                      footer: SizedBox(
                        height:
                            sizeProvider.dashBoardTitleContainerHeight * 0.2,
                        width: sizeProvider.dashBoardTitleContainerWidth * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              DateFormat('dd MMM').format(DateTime.now()),
                              style: const TextStyle(
                                  color: blueShade,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      child: SizedBox(
                        height:
                            sizeProvider.dashBoardTitleContainerHeight * 0.6,
                        width: sizeProvider.dashBoardTitleContainerWidth * 0.8,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Hey ${FirebaseAuth.instance.currentUser!.email!.split('@')[0]} \nYour Things',
                            style: const TextStyle(
                              color: blueShade,
                              // fontWeight: FontWeight.w600,
                              // fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                top: sizeProvider.todoStatCardTop,
                left: sizeProvider.todoStatCardLeft,
                child: Container(
                  height: sizeProvider.todoStatCardHeight,
                  width: sizeProvider.todoStatCardWidth,
                  color: darkmgray,
                  // child: ChangeNotifierProvider<TodoDashboardProvider>(
                  //     create: (_) => TodoDashboardProvider(),
                  //     child: CardWidget()),
                  child: CardWidget(),
                ),
              ),

              // }),

              //   },
              // ),
              Positioned(
                top: sizeProvider.todoListViewTop,
                left: sizeProvider.todoListViewLeft,
                child: Container(
                  color: darkmgray,
                  height: sizeProvider.todoListViewHeight,
                  width: sizeProvider.todoListViewWidth,
                  // child: ChangeNotifierProvider<TodoDashboardProvider>(
                  //     create: (_) => TodoDashboardProvider(),
                  //     child: TodoList()),
                  child: TodoList(),
                ),
              ),
              // GetBuilder<TodoDashboardController>(
              //   id: 'todoListView',
              //   builder: (controller) {
              //     return;
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       alignment: FractionalOffset.topLeft,
              //       child: GestureDetector(
              //         child: const Icon(Icons.menu, color: Colors.white),
              //         onTap: () {
              //           {
              //             NavigationDrawerWidget();
              //           }
              //         },
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        drawer: NavigationDrawerWidget(),
      );
    });
  }
}

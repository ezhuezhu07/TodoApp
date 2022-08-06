import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/controllers/size_controller.dart';
import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/widgets/card_widget.dart';
import 'package:todoapp/widgets/drawer_widget.dart';
import 'package:todoapp/widgets/todo_list_widget.dart';

class TodoDashBoard extends StatelessWidget {
  // const TodoDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizeController sizeController = Get.find<SizeController>();

    SizeController sizeController = Get.put(SizeController());
    sizeController.setSize(context);
    Get.put(TodoDashboardController());
    return GetBuilder<TodoDashboardController>(
      init: TodoDashboardController(),
      builder: ((controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: darkmgray,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Todo App",
                style: TextStyle(
                  color: blueShade,
                  fontSize: sizeController.fontSize1,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/addTodoPage');
            },
            backgroundColor: blueShadeLight,
            child: const Icon(
              Icons.add,
              color: blueShade,
            ),
          ),
          body: SizedBox(
            height: sizeController.screenHeight,
            width: sizeController.screenWidth,
            child: Stack(
              children: [
                GetBuilder<TodoDashboardController>(
                  id: 'todoDashBoardContainer',
                  builder: (_) {
                    return Positioned(
                        top: sizeController.dashBoardTitleContainerTop,
                        left: sizeController.dashBoardTitleContainerLeft,
                        child: Container(
                          color: darkmgray,
                          height: sizeController.dashBoardTitleContainerHeight,
                          width: sizeController.dashBoardTitleContainerWidth,
                          child: GridTile(
                            footer: SizedBox(
                              height:
                                  sizeController.dashBoardTitleContainerHeight *
                                      0.2,
                              width:
                                  sizeController.dashBoardTitleContainerWidth *
                                      0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    DateFormat('dd MMM').format(DateTime.now()),
                                    style: const TextStyle(
                                        color: graymid,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            child: SizedBox(
                              height:
                                  sizeController.dashBoardTitleContainerHeight *
                                      0.6,
                              width:
                                  sizeController.dashBoardTitleContainerWidth *
                                      0.8,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Hey ${FirebaseAuth.instance.currentUser!.email!.split('@')[0]} \nYour Things',
                                  style: const TextStyle(
                                    color: graymid,
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
                GetBuilder<TodoDashboardController>(
                  id: 'todoStatCard',
                  builder: (controller) {
                    return Positioned(
                      top: sizeController.todoStatCardTop,
                      left: sizeController.todoStatCardLeft,
                      child: Container(
                        height: sizeController.todoStatCardHeight,
                        width: sizeController.todoStatCardWidth,
                        color: darkmgray,
                        child: CardWidget(),
                      ),
                    );
                  },
                ),
                GetBuilder<TodoDashboardController>(
                  id: 'todoListView',
                  builder: (controller) {
                    return Positioned(
                      top: sizeController.todoListViewTop,
                      left: sizeController.todoListViewLeft,
                      child: Container(
                        color: darkmgray,
                        height: sizeController.todoListViewHeight,
                        width: sizeController.todoListViewWidth,
                        child: TodoList(),
                      ),
                    );
                  },
                ),
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
      }),
    );
  }
}

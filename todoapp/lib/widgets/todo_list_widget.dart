import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/controllers/size_controller.dart';
import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/widgets/todo_list_item_widget.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> tempTodoList = [
    TodoModel(
        title: 'ABHNJJ',
        description: 'JJBJKJ',
        label: 'YUGFT',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'ABHNJJ',
        description: 'JJBJKJ',
        label: 'YUGFT',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'ABHNJJ',
        description: 'JJBJKJ',
        label: 'YUGFT',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'ABHNJJ',
        description: 'JJBJKJ',
        label: 'YUGFT',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'ABHNJJ',
        description: 'JJBJKJ',
        label: 'YUGFT',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
  ];

  // static StreamTransformer transformer<T>(
  //         T Function(Map<String, dynamic> json) fromJson) =>
  //     StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
  //       handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
  //         final snaps = data.docs.map((doc) => doc.data()).toList();
  //         final objects = snaps.map((json) => fromJson(json)).toList();

  //         sink.add(objects);
  //       },
  //     );
  // final Colors.white = Colors.white;

  @override
  Widget build(BuildContext context) {
    SizeController sizeController = Get.find<SizeController>();
    final controller = Get.find<TodoDashboardController>();

    // SizeController sizeController = Get.put(SizeController());
    // sizeController.setSize(context);

    final animatedListKey = GlobalKey<AnimatedListState>();
    final tempanimatedListKey = GlobalKey<AnimatedListState>();

    return StreamBuilder<List<TodoModel>>(
        stream: controller.fetchTodo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GetBuilder<TodoDashboardController>(
              id: 'shimmerAnimation',
              builder: (shimmerController) {
                return shimmerController.shimmerEnabled
                    ? Shimmer.fromColors(
                        baseColor: darkmgray,
                        highlightColor: graylight,
                        enabled: shimmerController.shimmerEnabled,
                        child: AnimatedList(
                            key: tempanimatedListKey,
                            initialItemCount: shimmerController.shimmerEnabled
                                ? tempTodoList.length
                                : controller.todoList.length,
                            itemBuilder: (context, index, animation) =>
                                TodoListItemWidget(
                                  item: shimmerController.shimmerEnabled
                                      ? tempTodoList[index]
                                      : controller.todoList[index],
                                  animation: animation,
                                  onClicked: () => deleteItem(
                                      index, tempanimatedListKey, controller),
                                )))
                    : Container(
                        width: 0,
                      );
              },
            );
          } else if (snapshot.hasData) {
            print('fetched data success fully');
            controller.shimmerEnabled = false;
            controller.update([controller.shimmerAnimation]);
            return AnimatedList(
                key: animatedListKey,
                initialItemCount: controller.todoList.length,
                itemBuilder: (context, index, animation) => TodoListItemWidget(
                      item: controller.todoList[index],
                      animation: animation,
                      onClicked: () =>
                          deleteItem(index, animatedListKey, controller),
                    ));
          } else {
            return const Center(
              child: Text('No Todos'),
            );
          }
        });
  }

  void deleteItem(int index, GlobalKey<AnimatedListState> key,
      TodoDashboardController controller) async {
    final removedItem = controller.todoList[index];
    controller.todoList.removeAt(index);
    await FirebaseFirestore.instance
        .collection(AppConst.todoDatabaseName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConst.todoUserDatabaseName)
        .doc(removedItem.createdTime)
        .delete();
    key.currentState!.removeItem(
        index,
        (context, animation) => TodoListItemWidget(
            item: removedItem, animation: animation, onClicked: () {}),
        duration: const Duration(milliseconds: 600));
    await controller.initializeTodosCount();
  }
}

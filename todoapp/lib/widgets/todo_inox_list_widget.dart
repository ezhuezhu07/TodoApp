import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/size_providers.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';
import 'package:todoapp/widgets/todo_inbox_list_item_widget.dart';

class TodoInboxList extends StatelessWidget {
  bool complete;
  TodoInboxList({super.key, required this.complete});
  final List<TodoModel> tempTodoList = [
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'Personal',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'Business',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'Personal',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'Business',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
  ];

  @override
  Widget build(BuildContext context) {
    final animatedListKey = GlobalKey<AnimatedListState>();
    final tempanimatedListKey = GlobalKey<AnimatedListState>();
    final provider = Provider.of<TodoDashboardProvider>(context, listen: false);
    final sizeProvider = Provider.of<SizeProvider>(context, listen: false);
    return Consumer<TodoDashboardProvider>(builder: (context, _, child) {
      print('Building todo list');
      return FutureBuilder<List<TodoModel>>(
          initialData: const <TodoModel>[],
          future: complete
              ? provider.fetchCompletedTodoData()
              : provider.fetchInboxData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: graymid,
                  highlightColor: uiLightFontColor,
                  enabled: true,
                  child: AnimatedList(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      key: tempanimatedListKey,
                      initialItemCount: tempTodoList.length,
                      itemBuilder: (context, index, animation) =>
                          TodoInboxListItemWidget(
                            item: tempTodoList[index],
                            animation: animation,
                            onClicked: () => deleteItem(
                                index,
                                tempanimatedListKey,
                                Provider.of<TodoDashboardProvider>(context,
                                    listen: false)),
                          )));
            } else if (snapshot.hasData) {
              if (!complete) {
                return _.allTodoList.isNotEmpty
                    ? AnimatedList(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        key: animatedListKey,
                        initialItemCount: _.allTodoList.length,
                        itemBuilder: (context, index, animation) =>
                            TodoInboxListItemWidget(
                              item: _.allTodoList[index],
                              animation: animation,
                              onClicked: () =>
                                  deleteItem(index, animatedListKey, _),
                            ))
                    : SizedBox(
                        height: sizeProvider.todoListViewHeight * 0.35,
                        child: const Center(
                          child: Text(
                            'Inbox is Empty',
                            style: TextStyle(color: graymid),
                          ),
                        ),
                      );
              } else {
                return _.allTodoCompletedList.isNotEmpty
                    ? AnimatedList(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        key: animatedListKey,
                        initialItemCount: _.allTodoCompletedList.length,
                        itemBuilder: (context, index, animation) =>
                            TodoInboxListItemWidget(
                              item: _.allTodoCompletedList[index],
                              animation: animation,
                              onClicked: () =>
                                  deleteItem(index, animatedListKey, _),
                            ))
                    : SizedBox(
                        height: sizeProvider.todoListViewHeight * 0.35,
                        child: const Center(
                          child: Text(
                            'Yet to Complete',
                            style: TextStyle(color: graymid),
                          ),
                        ),
                      );
              }

              // });
            } else {
              return const Center(
                child: Text(
                  'No Todos',
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          });
    });
  }

  void deleteItem(int index, GlobalKey<AnimatedListState> key,
      TodoDashboardProvider controller) async {
    final removedItem = complete
        ? controller.allTodoCompletedList[index]
        : controller.allTodoList[index];
    controller.todoList.removeAt(index);
    await FirebaseFirestore.instance
        .collection(AppConst.todoDatabaseName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConst.todoUserDatabaseName)
        .doc(removedItem.createdTime)
        .delete();
    key.currentState!.removeItem(
        index,
        (context, animation) => TodoInboxListItemWidget(
            item: removedItem, animation: animation, onClicked: () {}),
        duration: const Duration(milliseconds: 600));
    await controller.initializeTodosCount();
  }
}

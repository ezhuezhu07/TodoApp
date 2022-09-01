import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';
import 'package:todoapp/widgets/todo_list_item_widget.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> tempTodoList = [
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'label',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'label',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'label',
        date: DateTime.now(),
        createdTime: DateTime.now().toString()),
    TodoModel(
        title: 'title',
        description: 'description',
        label: 'label',
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
    final animatedListKey = GlobalKey<AnimatedListState>();
    final tempanimatedListKey = GlobalKey<AnimatedListState>();

    final provider = Provider.of<TodoDashboardProvider>(context, listen: false);
    print('Todo list is building');
    return Consumer<TodoDashboardProvider>(builder: (context, _, child) {
      return FutureBuilder<List<TodoModel>>(
          initialData: const <TodoModel>[],
          future: provider.fetchTodo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                _.todoList.isEmpty) {
              return Shimmer.fromColors(
                  baseColor: darkmgray,
                  highlightColor: blueShadeHover,
                  enabled: true,
                  child: AnimatedList(
                      key: tempanimatedListKey,
                      initialItemCount: tempTodoList.length,
                      itemBuilder: (context, index, animation) =>
                          TodoListItemWidget(
                            item: tempTodoList[index],
                            animation: animation,
                            onClicked: () => deleteItem(
                                index,
                                tempanimatedListKey,
                                Provider.of<TodoDashboardProvider>(context,
                                    listen: false)),
                          )));
            } else if (snapshot.hasData) {
              // return Consumer<TodoDashboardProvider>(
              //     builder: (context, _, child) {
              print('Todo Animated list ${_.todoList}');
              return AnimatedList(
                  key: animatedListKey,
                  initialItemCount: _.todoList.length,
                  itemBuilder: (context, index, animation) =>
                      TodoListItemWidget(
                        item: _.todoList[index],
                        animation: animation,
                        onClicked: () => deleteItem(index, animatedListKey, _),
                      ));
              // });
            } else {
              return const Center(
                child: Text('No Todos'),
              );
            }
          });
    });
    // return Consumer<TodoDashboardProvider>(builder: (context, provider, _) {

    // });
  }

  void deleteItem(int index, GlobalKey<AnimatedListState> key,
      TodoDashboardProvider controller) async {
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

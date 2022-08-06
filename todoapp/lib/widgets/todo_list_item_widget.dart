import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/models/todo_model.dart';

class TodoListItemWidget extends StatelessWidget {
  final TodoModel item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const TodoListItemWidget({
    required this.item,
    required this.animation,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(item.title),
        sizeFactor: animation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: item.isCompleted == false
              ? Slidable(
                  startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                            key: Key(item.createdTime),
                            label: 'Edit',
                            backgroundColor: greenlight,
                            foregroundColor: green,
                            icon: Icons.edit,
                            onPressed: (context) {
                              Get.toNamed('/editTodoPage', arguments: [item]);
                            })
                      ]),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        label: 'Completed',
                        backgroundColor: purplelight,
                        foregroundColor: purple,
                        icon: Icons.delete,
                        onPressed: (context) async {
                          item.isCompleted = true;
                          final docUpdate = FirebaseFirestore.instance
                              .collection(AppConst.todoDatabaseName)
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection(AppConst.todoUserDatabaseName)
                              .doc(item.createdTime.toString());
                          docUpdate.update(item.toJson());
                          Get.find<TodoDashboardController>().update();
                          await Get.find<TodoDashboardController>()
                              .initializeTodosCount();
                        },
                      ),
                    ],
                  ),
                  child: buildTodoWigetItem(context),
                )
              : buildTodoWigetItem(context),
        ));
  }

  Widget buildTodoWigetItem(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppConst.labelbgColors[item.label],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 32,
              backgroundColor: AppConst.labelbgColors[item.label],
              child: Text(
                item.label.substring(0, 3),
                style: TextStyle(color: AppConst.labelfgColors[item.label]),
              ),
            ),
            title: Text(
              item.title,
              style: TextStyle(
                  fontSize: 25,
                  color: AppConst.labelfgColors[item.label],
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item.description,
              style: TextStyle(
                  fontSize: 20,
                  color: AppConst.labelfgColors[item.label],
                  fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              tooltip: 'To delete it from the list',
              icon: Icon(
                Icons.delete,
                color: AppConst.labelfgColors[item.label],
                size: 32,
              ),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}

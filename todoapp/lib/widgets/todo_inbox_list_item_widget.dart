import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/consts.dart';
// import 'package:todoapp/controllers/todo_dashboard_controller.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/size_providers.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';
import 'package:todoapp/views/edit_todo_page.dart';
import 'package:todoapp/widgets/custom_page_route_animation.dart';

class TodoInboxListItemWidget extends StatelessWidget {
  final TodoModel item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const TodoInboxListItemWidget({
    required this.item,
    required this.animation,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoDashboardProvider =
        Provider.of<TodoDashboardProvider>(context, listen: false);
    // return Consumer<TodoDashboardProvider>(builder: (context, myprovider, __) {
    //   return
    // });
    return SizeTransition(
        key: ValueKey(item.title),
        sizeFactor: animation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: item.isCompleted == false || item.isCompleted == null
              ? Slidable(
                  startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                            key: Key(item.createdTime),
                            label: 'Edit',
                            backgroundColor: uiWhiteColor,
                            foregroundColor: uiBcakgroundColor,
                            icon: Icons.edit_outlined,
                            onPressed: (context) {
                              todoDashboardProvider.setEditTodo(item);
                              Navigator.push(
                                context,
                                CustomPageRouteAnimation(
                                    child: EditTodoPage(
                                  todoModel: item,
                                )),
                              );
                              // Get.toNamed('/editTodoPage', arguments: [item]);
                            })
                      ]),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        label: 'Done',
                        backgroundColor: uiWhiteColor,
                        foregroundColor: uiBcakgroundColor,
                        icon: Icons.done_all_outlined,
                        onPressed: (context) async {
                          item.isCompleted = true;
                          final docUpdate = FirebaseFirestore.instance
                              .collection(AppConst.todoDatabaseName)
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection(AppConst.todoUserDatabaseName)
                              .doc(item.createdTime.toString());
                          print('Completed item ${item.toJson()}');
                          docUpdate.update(item.toJson());
                          await todoDashboardProvider.initializeTodosCount();
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
        child: Consumer<SizeProvider>(builder: (context, sizeProvider, child) {
          return Container(
            margin: const EdgeInsets.all(8),
            width: sizeProvider.todoListViewWidth,
            height: sizeProvider.todoListViewHeight * 0.15,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 9,
                  child: SizedBox(
                    width: sizeProvider.todoListViewWidth * 0.9,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      leading: CircleAvatar(
                        backgroundColor: graymid,
                        radius: 24,
                        // minRadius: 18,
                        // maxRadius: 28,
                        child: CircleAvatar(
                          radius: 22,
                          // minRadius: 15,
                          // maxRadius: 25,
                          backgroundColor: uiWhiteColor,
                          // foregroundColor: uiButtonColor,
                          child: Icon(AppConst.labelIcons[item.label],
                              size: 27.0, color: uiBcakgroundColor),
                        ),
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: sizeProvider.fontSize5 * 1.25,
                            color: Colors.black,
                            fontFamily: 'Rozanova_Medium',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item.description,
                        style: TextStyle(
                            fontSize: sizeProvider.fontSize5,
                            color: graymid,
                            fontFamily: 'Rozanova_Light',
                            fontWeight: FontWeight.normal),
                      ),
                      // dense: true,
                      trailing: FittedBox(
                        // fit: BoxFit.scaleDown,
                        child: Text(
                          DateFormat('dd MMM').format(item.date).toString(),
                          style: TextStyle(
                              fontSize: sizeProvider.fontSize5,
                              color: graymid,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Divider(
                    height: 10,
                    indent: 5,
                    endIndent: 5,
                    color: graymid,
                    thickness: sizeProvider.screenHeight * 0.0025,
                  ),
                )
              ],
            ),
          );
        }),
      );
}

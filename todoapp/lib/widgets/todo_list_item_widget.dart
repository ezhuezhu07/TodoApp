// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:intl/intl.dart';
// // import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:todoapp/colors.dart';
// import 'package:todoapp/consts.dart';
// // import 'package:todoapp/controllers/todo_dashboard_controller.dart';
// import 'package:todoapp/models/todo_model.dart';
// import 'package:todoapp/providers/size_providers.dart';
// import 'package:todoapp/providers/todo_dashboard_provider.dart';
// import 'package:todoapp/views/edit_todo_page.dart';
// import 'package:todoapp/widgets/custom_page_route_animation.dart';

// class TodoListItemWidget extends StatelessWidget {
//   final TodoModel item;
//   final Animation<double> animation;
//   final VoidCallback? onClicked;

//   const TodoListItemWidget({
//     required this.item,
//     required this.animation,
//     required this.onClicked,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final todoDashboardProvider =
//         Provider.of<TodoDashboardProvider>(context, listen: false);
//     // return Consumer<TodoDashboardProvider>(builder: (context, myprovider, __) {
//     //   return
//     // });
//     return SizeTransition(
//         key: ValueKey(item.title),
//         sizeFactor: animation,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16),
//           child: item.isCompleted == false || item.isCompleted == null
//               ? Slidable(
//                   startActionPane: ActionPane(
//                       motion: const DrawerMotion(),
//                       extentRatio: 0.25,
//                       children: [
//                         SlidableAction(
//                             key: Key(item.createdTime),
//                             label: 'Edit',
//                             backgroundColor: greenlight,
//                             foregroundColor: green,
//                             icon: Icons.edit,
//                             onPressed: (context) {
//                               todoDashboardProvider.setEditTodo(item);
//                               Navigator.push(
//                                 context,
//                                 CustomPageRouteAnimation(
//                                     child: EditTodoPage(
//                                   todoModel: item,
//                                 )),
//                               );
//                               // Get.toNamed('/editTodoPage', arguments: [item]);
//                             })
//                       ]),
//                   endActionPane: ActionPane(
//                     motion: const DrawerMotion(),
//                     extentRatio: 0.25,
//                     children: [
//                       SlidableAction(
//                         label: 'Completed',
//                         backgroundColor: purplelight,
//                         foregroundColor: purple,
//                         icon: Icons.delete,
//                         onPressed: (context) async {
//                           item.isCompleted = true;
//                           final docUpdate = FirebaseFirestore.instance
//                               .collection(AppConst.todoDatabaseName)
//                               .doc(FirebaseAuth.instance.currentUser!.uid)
//                               .collection(AppConst.todoUserDatabaseName)
//                               .doc(item.createdTime.toString());
//                           print('Completed item ${item.toJson()}');
//                           docUpdate.update(item.toJson());
//                           await todoDashboardProvider.initializeTodosCount();
//                         },
//                       ),
//                     ],
//                   ),
//                   child: buildTodoWigetItem(context),
//                 )
//               : buildTodoWigetItem(context),
//         ));
//   }

//   Widget buildTodoWigetItem(BuildContext context) => GestureDetector(
//         onTap: () {},
//         child: Consumer<SizeProvider>(builder: (context, sizeProvider, child) {
//           return Container(
//             margin: const EdgeInsets.all(8),
//             width: sizeProvider.todoListViewWidth,
//             height: sizeProvider.todoListViewHeight * 0.175,
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               // mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: sizeProvider.todoListViewWidth * 0.6,
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(16),
//                     leading: Container(
//                       color: uiWhiteColor,
//                       decoration: BoxDecoration(
//                         color: uiLightFontColor,
//                         borderRadius: BorderRadius.circular(0.5),
//                       ),
//                       child: Icon(AppConst.labelIcons[item.label],
//                           size: 30, color: AppConst.labelfgColors[item.label]),
//                     ),
//                     title: Text(
//                       item.title,
//                       style: TextStyle(
//                           fontSize: 25,
//                           color: AppConst.labelfgColors[item.label],
//                           fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       item.description,
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: AppConst.labelfgColors[item.label],
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: sizeProvider.todoListViewWidth * 0.3,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     // mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: Text(
//                           DateFormat('dd MMM').format(item.date).toString(),
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: AppConst.labelfgColors[item.label],
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: IconButton(
//                           tooltip: 'To delete it from the list',
//                           icon: Icon(
//                             Icons.delete,
//                             color: AppConst.labelfgColors[item.label],
//                             size: 30,
//                           ),
//                           onPressed: onClicked,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       );
// }

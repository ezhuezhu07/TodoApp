import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';

class TodoDashboardController extends GetxController {
  final String todoDashBoardContainer = 'todoDashBoardContainer';
  final String todoStatCard = 'todoStatCard';
  final String todoListView = 'todoListView';
  final String shimmerAnimation = 'shimmerAnimation';
  late int todosCount;
  late int completedTodosCount;
  late int planningTodosCount;
  late int developmentTodosCount;
  late int testingTodosCount;
  late int deploymentTodosCount;
  List<TodoModel> todoList = [];

  bool shimmerEnabled = true;
  String selectedCard = 'Todos';

  Stream<List<TodoModel>> fetchTodo() async* {
    todoList.clear();

    switch (selectedCard) {
      case 'Todos':
        try {
          await FirebaseFirestore.instance
              .collection(AppConst.todoDatabaseName)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConst.todoUserDatabaseName)
              .where('isCompleted', isEqualTo: false)
              .orderBy(TodoFieldData.createdTime, descending: true)
              .get()
              .then((querySnapshot) {
            for (var element in querySnapshot.docs) {
              todoList.add(TodoModel.fromJson(element.data()));
            }
          });
        } catch (e) {
          print('error $e');
        }
        break;
      case 'Completed':
        try {
          await FirebaseFirestore.instance
              .collection(AppConst.todoDatabaseName)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConst.todoUserDatabaseName)
              .where('isCompleted', isEqualTo: true)
              .orderBy(TodoFieldData.createdTime, descending: true)
              .get()
              .then((querySnapshot) {
            for (var element in querySnapshot.docs) {
              todoList.add(TodoModel.fromJson(element.data()));
            }
          });
        } catch (e) {
          print('error $e');
        }
        break;
      case 'Development':
        try {
          await FirebaseFirestore.instance
              .collection(AppConst.todoDatabaseName)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConst.todoUserDatabaseName)
              .orderBy(TodoFieldData.createdTime, descending: true)
              .where('label', isEqualTo: 'Development')
              .get()
              .then((querySnapshot) {
            for (var element in querySnapshot.docs) {
              todoList.add(TodoModel.fromJson(element.data()));
            }
          });
        } catch (e) {
          print('error $e');
        }
        break;
      default:
        try {
          await FirebaseFirestore.instance
              .collection(AppConst.todoDatabaseName)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConst.todoUserDatabaseName)
              .orderBy(TodoFieldData.createdTime, descending: true)
              .where('label', isEqualTo: selectedCard)
              .get()
              .then((querySnapshot) {
            for (var element in querySnapshot.docs) {
              todoList.add(TodoModel.fromJson(element.data()));
            }
          });
        } catch (e) {
          print('error $e');
        }
        break;
    }
    yield todoList;
  }

  @override
  void onInit() async {
    await initializeTodosCount();
  }

  initializeTodosCount() async {
    todosCount = 0;
    completedTodosCount = 0;
    planningTodosCount = 0;
    developmentTodosCount = 0;
    testingTodosCount = 0;
    deploymentTodosCount = 0;
    try {
      await FirebaseFirestore.instance
          .collection(AppConst.todoDatabaseName)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(AppConst.todoUserDatabaseName)
          .orderBy(TodoFieldData.createdTime, descending: true)
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          final todo = TodoModel.fromJson(element.data());

          // print('Completed : ${todo.isCompleted}');
          if (todo.isCompleted != null) {
            if (todo.isCompleted == false) {
              todosCount += 1;
            } else {
              completedTodosCount += 1;
            }
            switch (todo.label) {
              case 'Planning':
                planningTodosCount += 1;
                break;

              case 'Development':
                developmentTodosCount += 1;
                break;

              case 'Testing':
                testingTodosCount += 1;
                break;

              case 'Deployment':
                deploymentTodosCount += 1;
                break;
            }
          }
        }
      });
    } catch (e) {
      print('error $e');
    }
    update([todoStatCard]);
  }

//   Stream<List<TodoModel>> readTodoData() => FirebaseFirestore.instance
//       .collection(AppConst.todoDatabaseName)
//       .orderBy(TodoFieldData.createdTime, descending: true)
//       .snapshots()
//       .transform(Utils.transformer(TodoModel.fromJson));
}

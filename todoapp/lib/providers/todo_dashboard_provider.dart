import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/consts.dart';
import 'package:todoapp/models/todo_model.dart';

class TodoDashboardProvider with ChangeNotifier {
  final String todoDashBoardContainer = 'todoDashBoardContainer';
  final String todoStatCard = 'todoStatCard';
  final String todoListView = 'todoListView';
  final String shimmerAnimation = 'shimmerAnimation';
  // int todosCount = 0;
  // int completedTodosCount = 0;
  // int planningTodosCount = 0;
  // int developmentTodosCount = 0;
  // int testingTodosCount = 0;
  // int deploymentTodosCount = 0;
  List<TodoModel> _todoList = [];
  List<String> todoTypes = [
    'Todos',
    'Completed',
    'Planning',
    'Development',
    'Testing',
    'Deployment'
  ];
  Map<String, int> todoCountList = {
    'Todos': 0,
    'Completed': 0,
    'Planning': 0,
    'Development': 0,
    'Testing': 0,
    'Deployment': 0
  };

  List<TodoModel> get todoList => _todoList;

  bool _shimmerEnabled = true;
  String selectedCard = 'Todos';
  late TodoModel _editTodo;

  // Stream<List<TodoModel>
  //> streamTodoList = fetchTodo();

  TodoModel get editTodo => _editTodo;

  void setEditTodo(TodoModel model) {
    _editTodo = model;
  }

  //getter
  bool get shimmerEnabled => _shimmerEnabled;

  void setSelecedCard(String cardName) async {
    selectedCard = cardName;
    notifyListeners();
  }

  void setShimmerEnabled(bool value) {
    _shimmerEnabled = value;
    // notifyListeners();
  }

  // @override
  // void onInit() async {
  //   // super.
  //   print('Init state called');
  //   await initializeTodosCount();
  // }

  // void initializeTodoList() {
  //   _todoList = <TodoModel>[];
  //   notifyListeners();
  // }

  Future<List<TodoModel>> fetchTodo() async {
    print('Todo Animated List in fetchTodo $selectedCard');
    _todoList = <TodoModel>[];
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
              _todoList.add(TodoModel.fromJson(element.data()));
              // print(_todoList.last.toJson());
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
              // print('Completed todos: ${element.data()}');
              _todoList.add(TodoModel.fromJson(element.data()));
            }
          });
        } catch (e) {
          print('error $e');
        }
        break;
      case 'Planning':
        try {
          await FirebaseFirestore.instance
              .collection(AppConst.todoDatabaseName)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConst.todoUserDatabaseName)
              .orderBy(TodoFieldData.createdTime, descending: true)
              .where('label', isEqualTo: 'Planning')
              .get()
              .then((querySnapshot) {
            for (var element in querySnapshot.docs) {
              _todoList.add(TodoModel.fromJson(element.data()));
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
              _todoList.add(TodoModel.fromJson(element.data()));
            }
          });
        } catch (e) {
          print('error $e');
        }
        break;
    }
    print('Called fetch todos ${todoList.length}');
    // notifyListeners();
    return todoList;
  }

  Future<void> initializeTodosCount() async {
    print('initializing todos count');
    todoCountList.clear();
    todoCountList = {
      'Todos': 0,
      'Completed': 0,
      'Planning': 0,
      'Development': 0,
      'Testing': 0,
      'Deployment': 0
    };

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.todoDatabaseName)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(AppConst.todoUserDatabaseName)
          .orderBy(TodoFieldData.createdTime, descending: true)
          .get()
          .then((querySnapshot) {
        print('length from firebase ${querySnapshot.docs.length}');
        for (var element in querySnapshot.docs) {
          final todo = TodoModel.fromJson(element.data());
          if (todo.isCompleted == false) {
            todoCountList['Todos'] = todoCountList['Todos']! + 1;
          } else {
            todoCountList['Completed'] = todoCountList['Completed']! + 1;
          }

          switch (todo.label) {
            case 'Planning':
              todoCountList['Planning'] = todoCountList['Planning']! + 1;
              break;

            case 'Development':
              todoCountList['Development'] = todoCountList['Development']! + 1;
              break;

            case 'Testing':
              todoCountList['Testing'] = todoCountList['Testing']! + 1;
              break;

            case 'Deployment':
              todoCountList['Deployment'] = todoCountList['Deployment']! + 1;
              break;
          }
        }
      });
    } catch (e) {
      print('error $e');
    }
    print('Total no of todos $todoCountList');
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    notifyListeners();
    // });
  }
}

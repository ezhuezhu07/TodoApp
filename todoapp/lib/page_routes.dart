import 'package:get/get.dart';
import 'package:todoapp/views/add_todo_page.dart';
import 'package:todoapp/views/edit_todo_page.dart';
import 'package:todoapp/views/sign_in_page.dart';
import 'package:todoapp/views/sign_up_page.dart';

pageRoutes() => [
      // !Sign In Page , This is start of the app
      GetPage(name: "/", page: () => SignInPage()),

      GetPage(name: "/SignUpPage", page: () => SignUpPage()),

      GetPage(name: "/addTodoPage", page: () => AddTodoPage()),

      GetPage(name: "/editTodoPage", page: () => EditTodoPage()),
    ];

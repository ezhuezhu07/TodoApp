import 'package:flutter/material.dart';
import 'package:todoapp/colors.dart';

class AppConst {
  static const String todoDatabaseName = 'userTodoData';
  static const String todoUserDatabaseName = 'todo';
  static const Map<String, IconData> labelIcons = {
    'Planning': Icons.next_plan,
    'Development': Icons.code,
    'Testing': Icons.bug_report,
    'Deployment': Icons.cloud_queue,
  };

  static const Map<String, Color> labelbgColors = {
    'Planning': greenlight,
    'Development': orangelight,
    'Testing': pinklight,
    'Deployment': brownlight,
  };

  static const Map<String, Color> labelfgColors = {
    'Planning': green,
    'Development': orange,
    'Testing': pink,
    'Deployment': brown,
  };
}

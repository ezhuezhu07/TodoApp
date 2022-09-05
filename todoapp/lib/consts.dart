import 'package:flutter/material.dart';
import 'package:todoapp/colors.dart';

class AppConst {
  static const String todoDatabaseName = 'userTodoData';
  static const String todoUserDatabaseName = 'todo';
  static const Map<String, IconData> labelIcons = {
    // 'Planning': Icons.next_plan_outlined,
    // 'Development': Icons.code_outlined,
    // 'Testing': Icons.bug_report_outlined,
    // 'Deployment': Icons.cloud_queue_outlined,
    'Personal': Icons.home_outlined,
    'Business': Icons.mail_outline
  };

  static const Map<String, Color> labelbgColors = {
    // 'Planning': greenlight,
    // 'Development': orangelight,
    // 'Testing': pinklight,
    // 'Deployment': brownlight,
    'Personal': uiWhiteColor,
    'Business': uiWhiteColor
  };

  static const Map<String, Color> labelfgColors = {
    // 'Planning': green,
    // 'Development': orange,
    // 'Testing': pink,
    // 'Deployment': brown,
    'Personal': uiButtonColor,
    'Business': uiButtonColor
  };
}

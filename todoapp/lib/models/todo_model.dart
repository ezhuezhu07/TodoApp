import 'dart:convert';

import 'package:todoapp/utils.dart';

class TodoFieldData {
  static const createdTime = 'createdTime';
}

TodoModel todoModelFromJson(String str) =>
    TodoModel.fromJson(json.decode(str) as Map<String, dynamic>);

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  String title;
  String description;
  String label;
  bool? isCompleted;
  DateTime date;
  String createdTime;

  TodoModel({
    required this.title,
    required this.description,
    required this.label,
    required this.date,
    this.isCompleted,
    required this.createdTime,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      label: json['label'],
      date: Utils.toDateTime(json['date']),
      createdTime: json['createdTime']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'label': label,
        'isCompleted': isCompleted,
        'date': Utils.fromDateTimeToJson(date),
        'createdTime': createdTime,
      };
}

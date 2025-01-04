import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
        // ignore: prefer_final_fields
        List<Task> _tasks = <Task>[];
        final String _taskFileName = "tasks.json";
        String? _path;

        List<Task> get tasks => _tasks;

        TaskProvider() {
                _loadTasks();
                _init();
        }

        void addTask(Task task) {
                _tasks.add(task);
                notifyListeners();
        }

        Future<void> _init() async {
                final directory = await getApplicationDocumentsDirectory();
                _path = "${directory.path}/$_taskFileName";
                await _loadTasks();
        }

        Future<void> _loadTasks() async {
                try {
                        final file = File(_path!);
                        if (await file.exists()) {
                                final jsonString = await file.readAsString();
                                final List<dynamic> taskList = jsonDecode(jsonString);
                                _tasks = taskList.map((e) => Task.fromJson(e)).toList();
                        }
                } catch (e) {
                        // ignore: avoid_print
                        print(e);
                }
                notifyListeners();
        }

        Future<void> _saveTasks() async {
                try {
                        final file = File(_path!);
                        final jsonString = jsonEncode(_tasks.map((e) => e.toJson()).toList());
                        await file.writeAsString(jsonString);
                } catch (e) {
                        // ignore: avoid_print
                        print('Error saving tasks: $e');
                }
        }

        Future<void> deleteTask(int index) async {
                _tasks.removeAt(index);
                notifyListeners();
                await _saveTasks();
        }
}

extension TaskJson on Task {
        Map<String, dynamic> toJson() => {
               'title': title,
               'category': category,
               'deadline': deadline.toIso8601String(),
        };

        static Task fromJson(Map<String, dynamic> json) => Task(
                title: json['title'] as String,
                category: json['category'] as String,
                deadline: DateTime.parse(json['deadline'] as String)
        );
}

class Task {
        final String title;
        final String category;
        final DateTime deadline;

        Task({required this.title, required this.category, required this.deadline});

        factory Task.fromJson(Map<String, dynamic> json) => Task(
                title: json['title'],
                category: json['category'],
                deadline: DateTime.parse(json['deadline'])
        );

        Map<String, dynamic> toJson() => {
               'title': title,
               'category': category,
               'deadline': deadline.toIso8601String(),
        };
}

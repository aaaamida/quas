import 'dart:math';
import 'package:flutter/material.dart';
import 'list_box.dart';
import 'task_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
        const Home({super.key});

        @override
        State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
        final div = const SizedBox(height: 8);
        final ScrollController _scrollController = ScrollController();
        final int random = Random().nextInt(65535);

        @override
        Widget build(BuildContext context) {
                final tasks = Provider.of<TaskProvider>(context).tasks;
                return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => ListBox(
                                title: tasks[index].title,
                                deadline: tasks[index].deadline,
                                category: tasks[index].category,
                        ),
                );
        }
}


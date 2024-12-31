import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ListBox extends StatefulWidget {
        const ListBox({
                super.key,
                required this.id,
                required this.name,
                required this.deadline,
                this.category = ""
        });

        final String id;
        final String name;
        final DateTime deadline;
        final String category;

        @override
        State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
        @override
        Widget build(BuildContext context) {
                return Card.outlined(
                        child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: Checkbox(value: false, onChanged: (_) {}),
                                title: Text(widget.name),
                                trailing: Text(widget.deadline.toString()),
                        ),
                );
        }
}

class TaskCategory extends StatefulWidget {
        const TaskCategory({super.key, required this.name});

        final String name;

        @override
        State<TaskCategory> createState() => _TaskCategoryState();
}

class _TaskCategoryState extends State<TaskCategory> {
        @override Widget build(BuildContext context) {
                return Chip(
                        label: Text(
                                widget.name,
                                style: TextStyle(
                                        fontSize: 10,
                                        color: switch (AdaptiveTheme.of(context).mode) {
                                                AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                                                _                      => const Color(0xFF000000),
                                        }
                                )
                        ),
                        shape: const StadiumBorder(side: BorderSide(width: 0.1)),
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                        backgroundColor: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => const Color(0xFF5F5286).withAlpha(128),
                                _                      => Colors.white,
                        }
                );
        }
}

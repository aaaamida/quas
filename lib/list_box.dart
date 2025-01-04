import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class ListBox extends StatefulWidget {
        ListBox({
                super.key,
                required this.title,
                required this.deadline,
                this.category = ""
        });

        String title;
        DateTime deadline;
        String category;

        @override
        State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
        @override
        Widget build(BuildContext context) {
                // ignore: unused_local_variable
                final tasks = Provider.of<TaskProvider>(context).tasks;
                const pad = SizedBox(height: 6);
                Color cardBGColor = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color.fromRGBO(20, 20, 20, 0.1),
                        _                      => const Color(0xFFFFFFFF)
                };
                Color lineColor = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                        _                      => const Color(0xFF000000),
                };
                return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                contentPadding: const EdgeInsets.all(6),
                                                leading: Checkbox(
                                                        value: false,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                        side: BorderSide(
                                                                width: 1.5,
                                                                color: switch (AdaptiveTheme.of(context).mode) {
                                                                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                                                                        _                      => const Color(0xFF000000)
                                                                }
                                                        ),
                                                        onChanged: (_) {}
                                                ),
                                                title: Text(widget.title, style: TextStyle(color: lineColor)),
                                                trailing: Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Text(widget.deadline.toString(), style: TextStyle(color: lineColor)),
                                                ),
                                        ),
                                ),
                                pad
                        ],
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

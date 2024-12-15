import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ListBox extends StatefulWidget {
        const ListBox({
                super.key,
                required this.id,
                required this.name,
                required this.description,
                required this.deadline,
                this.category = ""
        });

        final String id;
        final String name;
        final String description;
        final DateTime deadline;
        final String category;

        @override
        State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
        List<Widget> listItems(BuildContext context) {
                final textColor = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                        _                      => const Color(0xFF000000),
                };

                return <Widget>[
                        IconButton(
                                onPressed: () {},
                                icon: Icon(
                                        Icons.check_outlined,
                                        color: switch (AdaptiveTheme.of(context).mode) {
                                                AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                                                _                      => const Color(0xFF000000),
                                        }
                                ),
                                tooltip: "Mark as done",
                        ),
                        // const SizedBox(width: 14),
                        Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                        Text(widget.name, style: TextStyle(fontSize: 12, color: textColor)),
                                        const SizedBox(height: 8),
                                        Text(widget.description, style: TextStyle(fontSize: 10, color: textColor)),
                                        const SizedBox(height: 6),
                                        widget.category.isNotEmpty ? TaskCategory(name: widget.category) : const SizedBox(),
                                ],
                        ),
                        const SizedBox(width: 24),
                        Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                        Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                        Text(
                                                                widget.deadline.toString().replaceRange(16, null, ""),
                                                                style: TextStyle(fontSize: 10, color: textColor)
                                                        )
                                                ],
                                        )
                                ]
                        ),
                ];
        }

        @override
        Widget build(BuildContext context) {
                return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                                height: 120,
                                width: MediaQuery.sizeOf(context).width - MediaQuery.paddingOf(context).horizontal - 16,
                                child: Container(
                                        decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: const Color(0xFF5F5286)),
                                                color: switch (AdaptiveTheme.of(context).mode) {
                                                        AdaptiveThemeMode.dark => const Color(0xFF5F5286),
                                                        _                      => const Color(0xFFFFFFFF),
                                                },
                                        ),
                                        child: Padding(
                                                padding: const EdgeInsets.only(right: 4, left: 4, top: 12, bottom: 12),
                                                child: Row(
                                                        children: listItems(context),
                                                ),
                                        ),
                                ),
                        )
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
        int rng(int range) {
                return Random().nextInt(range);
        }

        // ignore: prefer_typing_uninitialized_variables
        var red; var green; var blue; var alpha;
        int range = 255 ~/ 2;

        @override
        void initState() {
                super.initState();

                alpha = rng(range);
                red = rng(range);
                green = rng(range);
                blue = rng(range);
        }

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
                        shape: const StadiumBorder(side: BorderSide(width: 0.2)),
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                        backgroundColor: Color.fromARGB(alpha, red, green, blue),
                );
        }
}

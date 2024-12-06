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
                this.category = "None"
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

        List<Widget> boxChildren() {
                return <Widget>[
                        Checkbox(
                                value: null,
                                onChanged: null,
                                shape: const CircleBorder(),
                        ),
                        Column(
                                children: [
                                        Text(widget.name, style: const TextStyle(fontSize: 10)),
                                        const SizedBox(height: 8),
                                        Text(widget.description, style: const TextStyle(fontSize: 8)),
                                        const SizedBox(height: 12),
                                        TaskCategory(name: widget.category),
                                ],
                        ),
                        const Flex(direction: Axis.horizontal),
                        Column(
                                children: [
                                        Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                        Text(widget.deadline.toString(), style: const TextStyle(fontSize: 10))
                                                ],
                                        )
                                ]
                        )
                ];
        }

        @override
        Widget build(BuildContext context) {
                return Container(
                                color: switch (AdaptiveTheme.of(context).mode) { 
                                        AdaptiveThemeMode.dark => const Color(0xFF1E1E2F),
                                        _                      => const Color(0xFFFFFFFF),
                                },
                                decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFF5F5286)),
                                        boxShadow: const <BoxShadow>[
                                                BoxShadow(
                                                        color: Color.fromARGB(200, 200, 200, 255 ~/ 2),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0, 3)
                                                )
                                        ]
                                ),
                                // ignore: prefer_const_constructors
                                child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                                children: boxChildren(),
                                        ),
                                ),
                );
        }
}

class TaskCategory extends StatelessWidget {
        const TaskCategory({super.key, required this.name});
        final String name;
        
        int rng(int range) {
                return Random().nextInt(range);
        }

        @override Widget build(BuildContext context) {
                return Chip(
                        label: Text(name),
                        backgroundColor: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => Color.fromARGB(255, rng(255 ~/ 2), rng(255 ~/ 2), rng(255 ~/ 2)),
                                _                      => Color.fromARGB(255, rng(255), rng(255), rng(255)),
                        },
                );
        }
}

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

        List<Widget> listItems() {
                return <Widget>[
                        // TODO: add feature: task status changed on interaction
                        Checkbox(
                                value: null,
                                onChanged: (state) {},
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
                return SizedBox(
                        height: 100,
                        width: MediaQuery.sizeOf(context).width - MediaQuery.paddingOf(context).horizontal - 16,
                        child: Container(
                                color: switch (AdaptiveTheme.of(context).mode) { 
                                        AdaptiveThemeMode.dark => const Color(0xFF1E1E2F),
                                        _                      => const Color(0xFFFFFFFF),
                                },
                                decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFF5F5286)),
                                        boxShadow: const <BoxShadow>[
                                                BoxShadow(
                                                        color: Color.fromRGBO(200, 200, 200, 255 * 0.75),
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: listItems(),
                                        ),
                                ),
                        )
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
                        label: Text(name, style: const TextStyle(fontSize: 10)),
                        shape: const StadiumBorder(side: BorderSide(width: 0.2)),
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                        backgroundColor: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => Color.fromARGB(255, rng(255 ~/ 2), rng(255 ~/ 2), rng(255 ~/ 2)),
                                _                      => Color.fromARGB(255, rng(255), rng(255), rng(255)),
                        },
                );
        }
}

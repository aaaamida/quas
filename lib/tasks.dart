import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'list_box.dart';

class Home extends StatefulWidget {
        const Home({super.key});

        @override
        State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
        final div = const SizedBox(height: 8);
        final ScrollController _scrollController = ScrollController();
        final int random = Random().nextInt(65535);

        String uuidGen() => const Uuid().v4();

        @override
        Widget build(BuildContext context) {
                return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                                return ListBox(
                                        id: uuidGen(),
                                        name: "foo",
                                        description: "bar baz qux",
                                        deadline: DateTime(2025, 1, 1, 0, 0, 0),
                                        category: "Math",
                                );
                         },
                );
        }
}


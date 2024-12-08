import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'list_box.dart';

class Home extends StatefulWidget {
        const Home({super.key});

        @override
        State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
        final ScrollController _scroller = ScrollController();
        final div = const SizedBox(height: 8);

        @override
        Widget build(BuildContext context) {
                return ListView(
                        padding: const EdgeInsets.all(8),
                        controller: _scroller,
                        children: [
                                ListBox(id: "1", name: "foo", description: "bar baz qux", deadline: DateTime.now()),
                                div,
                                ListBox(id: "1", name: "foo", description: "bar baz qux", deadline: DateTime.now()),
                                div,
                                ListBox(id: "1", name: "foo", description: "bar baz qux", deadline: DateTime.now()),
                        ],
                );
                // return Container(
                //         color: switch (AdaptiveTheme.of(context).mode) {
                //                 AdaptiveThemeMode.dark => const Color(0xFF1E1E2F),
                //                 _                      => const Color(0xFFFFFFFF)
                //         }
                // );
        }
}


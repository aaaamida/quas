import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
        const Home({super.key});

        @override
        State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
        @override
        Widget build(BuildContext context) {
                // TODO: implement a `ListView` for the container child
                return Container(
                        color: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => const Color(0xFF1E1E2F),
                                _                      => const Color(0xFFFFFFFF)
                        }
                );
        }
}


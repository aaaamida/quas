import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsPage extends StatefulWidget {
        const SettingsPage({super.key});

        @override
        State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

        List<Widget> listContents() {
                return <Widget>[
                        Container(color: const Color(0xFF5F5286)),
                ];
        }

        @override
        Widget build(BuildContext context) {
                // ignore: unused_local_variable
                const pad = SizedBox(height: 8);
                // ignore: unused_local_variable
                const div = Divider(
                        height: 2,
                        thickness: 1,
                        indent: 8,
                        endIndent: 8,
                );
                final ScrollController scroller = ScrollController();
                return Container(
                        color: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => const Color(0xFF4A4659),
                                _                      => const Color(0xFFFFFFFF),
                        },
                        child: ListView(
                                controller: scroller,
                                padding: const EdgeInsets.all(8),
                                children: listContents(),
                        ),
                );
        }

}

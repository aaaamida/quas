import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
        const SettingsPage({super.key});

        @override
        State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
        final pad = const SizedBox(height: 8);
        final div = const Divider(
                height: 2,
                thickness: 1,
                indent: 8,
                endIndent: 8,
        );
        final ScrollController _scroller = ScrollController();

        List<Widget> listContents() {
                return <Widget>[
                        Container(color: const Color(0xFF5F5286)),
                ];
        }

        @override
        Widget build(BuildContext context) {
                return ListView(
                        controller: _scroller,
                        padding: const EdgeInsets.all(8),
                        children: listContents(),
                );
        }

}

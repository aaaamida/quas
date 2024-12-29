import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsPage extends StatefulWidget {
        const SettingsPage({super.key});

        @override
        State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
        bool appTheme = false;
        static const WidgetStateProperty<Icon> thumbIcon = WidgetStateProperty<Icon>.fromMap(
                <WidgetStatesConstraint, Icon>{
                        WidgetState.selected: Icon(Icons.light_mode_rounded),
                        WidgetState.any: Icon(Icons.dark_mode_rounded),
                }
        );

        Widget listContents(BuildContext context) {
                // ignore: unused_local_variable
                const pad = SizedBox(height: 8);
                // ignore: unused_local_variable
                const div = Divider(
                        height: 2,
                        thickness: 1,
                        indent: 8,
                        endIndent: 8,
                );
                Color textColor = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                        _                      => const Color(0xFF000000),
                };
                Color cardBGColor = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color.fromRGBO(200, 200, 200, 0.4),
                        _                      => const Color(0xFFFFFFFF)
                };
                return ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                                pad, pad, pad,
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                title: Text("App theme", style: TextStyle(color: textColor)),
                                                trailing: Switch(
                                                        thumbIcon: thumbIcon,
                                                        value: appTheme,
                                                        onChanged: (bool toggle) {
                                                                AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                                                                setState(() {
                                                                        appTheme = toggle;
                                                                });
                                                        }
                                                ),
                                        ),
                                )
                        ],
                );
        }

        @override
        Widget build(BuildContext context) {
                return Container(
                        color: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => const Color(0xFF4A4659),
                                _                      => const Color(0xFFFFFFFF),
                        },
                        child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: listContents(context),
                        ),
                );
        }

}

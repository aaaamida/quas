import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
        const SettingsPage({super.key});

        @override
        State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
        bool _appTheme = false;
        bool _notifyDisabled = false;
        static const WidgetStateProperty<Icon> _themeToggleIcon = WidgetStateProperty<Icon>.fromMap(
                <WidgetStatesConstraint, Icon>{
                        WidgetState.selected: Icon(Icons.light_mode_rounded),
                        WidgetState.any: Icon(Icons.dark_mode_rounded),
                }
        );
        static const WidgetStateProperty<Icon> _notificationToggleIcon = WidgetStateProperty<Icon>.fromMap(
                <WidgetStatesConstraint, Icon>{
                        WidgetState.selected: Icon(Icons.notifications_active),
                        WidgetState.any: Icon(Icons.notifications_off_outlined),
                }
        );

        Future<void> _loadTheme() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                setState(() {
                        _appTheme = prefs.getBool('appTheme') ?? false;
                });
        }

        Future<void> _saveTheme(bool value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('appTheme', value);
        }

        Future<void> _loadNotifySetting() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                setState(() {
                        _notifyDisabled = prefs.getBool('notifyDisabled') ?? false;
                });
        }

        Future<void> _saveNotifySetting(bool value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('notifyDisabled', value);
        }

        @override
        void initState() {
                super.initState();
                _loadTheme();
                _loadNotifySetting();
        }

        Widget listContents(BuildContext context) {
                // ignore: unused_local_variable
                const pad = SizedBox(height: 8);
                // ignore: unused_local_variable
                const div = Divider(
                        height: 2,
                        thickness: 0.5,
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
                return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                pad, pad, pad,
                                IconButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        icon: Icon(
                                                Icons.arrow_back_rounded,
                                                color: switch (AdaptiveTheme.of(context).mode) {
                                                        AdaptiveThemeMode.dark => Colors.white,
                                                        _                      => Colors.black,
                                                }
                                        )
                                ),
                                pad,
                                const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                                "ACCOUNT",
                                                style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        decoration: TextDecoration.none,
                                                )
                                        ),
                                ),
                                pad,
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                title: Text("Profile", style: TextStyle(color: textColor)),
                                                subtitle: Text(
                                                        "Log In or Sign Up to edit your profile",
                                                        style: TextStyle(
                                                                color: textColor,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w300,
                                                        )
                                                ),
                                                trailing: TextButton(
                                                        onPressed: () {},
                                                        child: Text("Log in", style: TextStyle(color: textColor))
                                                ),
                                        ),
                                ),
                                pad, pad,
                                const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                                "PREFERENCES",
                                                style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        decoration: TextDecoration.none,
                                                )
                                        ),
                                ),
                                pad,
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                title: Text("App Theme", style: TextStyle(color: textColor)),
                                                subtitle: Text(
                                                        "Toggle between dark and light theme",
                                                        style: TextStyle(
                                                                color: textColor,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w300,
                                                        )
                                                ),
                                                trailing: Switch(
                                                        thumbIcon: _themeToggleIcon,
                                                        value: _appTheme,
                                                        onChanged: (bool toggle) {
                                                                setState(() {
                                                                        _appTheme = toggle;
                                                                        _saveTheme(toggle);
                                                                });
                                                                switch (_appTheme) {
                                                                        case true:
                                                                                AdaptiveTheme.of(context).setLight();
                                                                                break;
                                                                        case false:
                                                                                AdaptiveTheme.of(context).setDark();
                                                                                break;
                                                                }
                                                        }
                                                ),
                                        ),
                                ),
                                pad,
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                title: Text("Push Notifications", style: TextStyle(color: textColor)),
                                                subtitle: Text(
                                                        "Enable or disable push notifications from this application", 
                                                        style: TextStyle(
                                                                color: textColor,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w300,
                                                        )
                                                ),
                                                trailing: Switch(
                                                        thumbIcon: _notificationToggleIcon,
                                                        value: _notifyDisabled,
                                                        onChanged: (toggle) {
                                                                setState(() {
                                                                        _notifyDisabled = toggle;
                                                                        _saveNotifySetting(toggle);
                                                                });
                                                        },
                                                ),
                                        ),
                                ),
                                pad,
                        ]
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

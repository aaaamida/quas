import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class Profile extends StatefulWidget {
        const Profile({super.key});

        @override
        State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

        Widget _profileContents() {
                const pad = SizedBox(height: 8);
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
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                                leading: Icon(Icons.account_circle, size: 24, color: textColor),
                                                title: Text("Guest", style: TextStyle(color: textColor)),
                                        ),
                                ),
                                pad,
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                                leading: Icon(Icons.access_time_outlined, color: textColor),
                                                title: Text("n", style: TextStyle(color: textColor)),
                                                subtitle: Text("Tasks Pending", style: TextStyle(color: textColor)),
                                        ),
                                ),
                                pad,
                                Card.outlined(
                                        color: cardBGColor,
                                        child: ListTile(
                                                contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                                leading: Icon(Icons.library_add_check, color: textColor),
                                                title: Text("n", style: TextStyle(color: textColor)),
                                                subtitle: Text("Tasks Completed", style: TextStyle(color: textColor)),
                                        ),
                                ),
                                pad,
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
                                child: _profileContents(),
                        ),
                );
        }
}

class PictureFrame extends StatelessWidget {
        const PictureFrame({super.key});

        @override
        Widget build(BuildContext context) {
                // ignore: prefer_const_constructors
                return CircleAvatar(
                        radius: 18,
                        foregroundImage: const AssetImage("assets/icons/avi.png"),
                        foregroundColor: const Color.fromRGBO(0, 0, 0, 0),
                );
        }
}

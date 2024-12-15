import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
        const Profile({super.key});

        @override
        State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

        bool pfpExists = false;

        Widget profileBoxContent() {
                return Column(
                        children: [
                                Row(
                                        children: [
                                                pfpExists
                                                        // TODO: add circular frame for profile picture if exists
                                                        ? const SizedBox()
                                                        // otherwise set as generic material icon
                                                        : const PictureFrame(),
                                                const SizedBox(width: 10),
                                                const Text("Guest", style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Yuruka", fontSize: 16)),
                                        ],
                                )
                        ],
                );
        }

        List<Widget> columnChildren() {
                return [
                        SizedBox(
                                height: 100,
                                width: 2000,
                                child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                                // ignore: prefer_const_constructors
                                                color: Color(0xFF8E508A),
                                                child: Padding(
                                                        padding: const EdgeInsets.all(8),
                                                        child: profileBoxContent(),
                                                ),
                                        ),
                                )
                        ),
                ];
        }

        @override
        Widget build(BuildContext context) {
                return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: columnChildren(),
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

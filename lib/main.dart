import 'package:flutter/material.dart';

void main() {
     // WidgetsFlutterBinding.ensureInitialized();
        runApp(const MyApp());
}

class MyApp extends StatelessWidget {
        const MyApp({super.key});

        @override
        Widget build(BuildContext context) {
                return MaterialApp(
                        title: "QuAs",
                        theme: ThemeData(
                                // default color scheme
                                // color0: #5F5286
                                // color1: #453B61
                                // color2: #8E508A
                                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5F5286)),
                                useMaterial3: true,
                        ),
                        home: const MyHomePage(title: 'Flutter Demo Home Page'),
                        debugShowCheckedModeBanner: false,
                );
        }
}

class MyHomePage extends StatefulWidget {
        const MyHomePage({super.key, required this.title});

        final String title;

        @override
        State<MyHomePage> createState() => _MyHomePageState();
}

enum AppTheme { light, dark }

class _MyHomePageState extends State<MyHomePage> {
        // light: #FFFFFF
        // dark: #1E1E2F
        int backgroundColor = 0xFFFFFFFF;
        AppTheme colorTheme = AppTheme.light;

        @override
        Widget build(BuildContext context) {
                // ignore: prefer_const_constructors
                return Scaffold(
                        appBar: AppBar(
                                title: const Text("QuAs", style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Yuruka")),
                                // TODO: make colorschemes customisable
                                // ignore: prefer_const_constructors
                                backgroundColor: Color(0xFF5F5286),
                        ),
                        // ignore: prefer_const_constructors
                        body: AppBody(theme: colorTheme),
                );
        }
}

class AppBody extends StatefulWidget {
        const AppBody({super.key, required this.theme});

        final AppTheme theme;

        @override
        State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {

        AppTheme background = AppTheme.light;

        Color backgroundTheme(AppTheme bg) {
                switch (bg) {
                        case AppTheme.light: 
                                return const Color(0xFFFFFFFF);
                        case AppTheme.dark:
                                return const Color(0xFF1E1E2F);
                }
        }

        @override
        Widget build(BuildContext context) {
                return Container(
                        color: backgroundTheme(widget.theme),
                        // ignore: prefer_const_constructors
                        child: Column(
                                // TODO: add task containers dynamically in a class definition
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [

                                ],
                        ),
                );
        }
}

class BottomBar extends StatefulWidget {
        const BottomBar({super.key});
        @override
        State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
        @override
        Widget build(BuildContext context) {
                return BottomAppBar(

                );
        }
}

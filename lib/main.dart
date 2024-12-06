import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'tasks.dart';
import 'categories.dart';
import 'profile.dart';

void main() {
     // WidgetsFlutterBinding.ensureInitialized();
        runApp(const MyApp());
}

class MyApp extends StatelessWidget {
        const MyApp({super.key});

        @override
        Widget build(BuildContext context) {
                return AdaptiveTheme(
                        light: ThemeData.light(useMaterial3: true),
                        dark: ThemeData.dark(useMaterial3: true),
                        initial: AdaptiveThemeMode.dark,
                        builder: (theme, darkTheme) => MaterialApp(
                                title: "QuAs",
                                theme: ThemeData(
                                        // default color scheme
                                        // color0: #5F5286
                                        // color1: #453B61
                                        // color2: #8E508A
                                        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5F5286)),
                                        useMaterial3: true,
                                        fontFamily: "Yuruka"
                                ),
                                home: const MyHomePage(),
                                debugShowCheckedModeBanner: false,
                        ),
                );
        }
}

class MyHomePage extends StatefulWidget {
        const MyHomePage({super.key});

        @override
        State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
        // light: #FFFFFF
        // dark: #1E1E2F
        int backgroundColor = 0xFFFFFFFF;
        int _selectedIndex = 0;
        // ignore: prefer_final_fields
        PageController _pageController = PageController(
                initialPage: 0,
                keepPage: true,
        );
        final _formkey = GlobalKey<FormState>();

        void changeTheme() {
                setState(
                        () {AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);}
                );
        }

        @override
        void initState() {
                super.initState();
        }

        List<BottomNavigationBarItem> bottomBarItems() {
                return const [
                        BottomNavigationBarItem(
                                icon: Icon(Icons.bookmark_border_outlined),
                                activeIcon: Icon(Icons.bookmark_outlined),
                                tooltip: "Move to tasks page",
                                label: "Task",
                        ),
                        BottomNavigationBarItem(
                                icon: Icon(Icons.bookmarks_outlined),
                                activeIcon: Icon(Icons.bookmarks),
                                tooltip: "Add, edit, or remove tasks",
                                label: "Manage",
                        ),
                        BottomNavigationBarItem(
                                icon: Icon(Icons.account_circle_outlined),
                                activeIcon: Icon(Icons.account_circle_rounded),
                                tooltip: "User Profile",
                                label: "Profile",
                        ),
                ];
        }

        void pageChanged(int index) {
                setState(() {
                        _selectedIndex = index;
                });
        }

        void barItemTapped(int index) {
                setState(() {
                        _selectedIndex = index;
                        // FIX: probably need to fix the transition when skipping one index over
                        // _pageController.animateToPage(index, duration: const Duration(milliseconds: 700), curve: Curves.easeOutExpo);
                        _pageController.jumpToPage(index);
                });
        }

        Widget formDialog() {
                return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                        Form(
                                                key: _formkey,
                                                child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: formItems(),
                                                ),
                                        )
                                ],
                        ),
                        actions: formButtons(),
                );
        }

        List<Widget> formItems() {
                return [
                        const Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Title",
                                                border: OutlineInputBorder(),
                                        ),
                                        enabled: false,
                                )
                        ),
                        const Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Category",
                                                border: OutlineInputBorder(),
                                        ),
                                        enabled: false,
                                )
                        ),
                        const Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Deadline",
                                                border: OutlineInputBorder(),
                                        ),
                                        enabled: false,
                                )
                        ),
                ];
        }

        List<Widget> formButtons() {
                return [
                        TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Cancel", style: TextStyle(fontFamily: "Helvetica"))
                        ),
                        const SizedBox(width: 10),
                        // ignore: prefer_const_constructors
                        TextButton(
                                onPressed: null,
                                child: const Text("Add", style: TextStyle(fontFamily: "Helvetica"))
                        ),
                ];
        }

        @override
        Widget build(BuildContext context) {
                AdaptiveThemeMode colorTheme = AdaptiveTheme.of(context).mode;
                // ignore: prefer_const_constructors
                return Scaffold(
                        appBar: AppBar(
                                title: const Text("QuAs", style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Yuruka")),
                                // TODO: make colorschemes customisable
                                // ignore: prefer_const_constructors
                                backgroundColor: switch (AdaptiveTheme.of(context).mode) {
                                        AdaptiveThemeMode.dark => const Color(0xFF3B3354),
                                        _                      => const Color(0xFF5F5286),
                                }
                        ),
                        // ignore: prefer_const_constructors
                        body: PageView(
                                controller: _pageController,
                                onPageChanged: (int index) {
                                        pageChanged(index);
                                },
                                children: const <Widget>[
                                        Home(),
                                        Categories(),
                                        Profile(),
                                ],
                        ),
                        // ignore: prefer_const_constructors
                        bottomNavigationBar: BottomNavigationBar(
                                backgroundColor: switch (AdaptiveTheme.of(context).mode) {
                                        AdaptiveThemeMode.dark => const Color(0xFF3B3354),
                                        _                      => const Color(0xFF5F5286),
                                },
                                currentIndex: _selectedIndex,
                                selectedItemColor: const Color(0xFFFFFFFF),
                                selectedLabelStyle: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
                                unselectedItemColor: const Color(0xFFACACAC),
                                unselectedLabelStyle: const TextStyle(color: Color(0xFFACACAC), fontWeight: FontWeight.w400),
                                items: bottomBarItems(),
                                onTap: (int index) {
                                        barItemTapped(index);
                                },
                        ),
                        floatingActionButton: _selectedIndex == 1 ? FloatingActionButton(
                                onPressed: () async {
                                        await showDialog<void>(
                                                context: context, 
                                                builder: (context) => formDialog(),
                                        );
                                },
                                backgroundColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark  => Color.alphaBlend(const Color(0xFFACACAC), Color(backgroundColor)),
                                        _                       => Color.alphaBlend(const Color(0xFFFFFFFF), Color(backgroundColor)),
                                },
                                hoverColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark  => const Color(0xFF919191),
                                        _                       => const Color(0xFFCCCCCC),
                                },
                                child: const Icon(Icons.add_outlined),
                        ) : const SizedBox(),
                );
        }
}

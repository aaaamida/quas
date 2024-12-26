import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'tasks.dart';
import 'categories.dart';
import 'profile.dart';
import 'settings.dart';
import 'input_form.dart';

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
                                label: "Tasks",
                        ),
                        BottomNavigationBarItem(
                                icon: Icon(Icons.bookmarks_outlined),
                                activeIcon: Icon(Icons.bookmarks),
                                tooltip: "Add, edit, or remove tasks",
                                label: "Manage",
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
                        _pageController.jumpToPage(index);
                });
        }

        PreferredSizeWidget appBar(int page, AdaptiveThemeMode colorTheme) {
                PreferredSizeWidget bar = switch (page) {
                        0 || 1 => AppBar(
                                title: const Text("QuAs", style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Yuruka", fontSize: 20)),
                                backgroundColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => const Color(0xFF4A4659),
                                        _                      => const Color(0xFFFFFFFF),
                                }
                        ),
                        _ => const PreferredSize(preferredSize: Size(24, 24), child: SizedBox(height: 24, width: 24)),
                };
                return bar;
        }

        List<Widget> drawerList(BuildContext context) {
                final highlight = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                        _                      => const Color(0xFF000000),
                };

                return <Widget>[
                        DrawerHeader(
                                decoration: const BoxDecoration(color: Color(0xFF5F5286)),
                                child: Text("QuAs", style: TextStyle(fontSize: 24, color: highlight)),
                        ),
                        ListTile(
                                leading: Icon(Icons.account_circle, color: highlight,),
                                title: Text("Profile", style: TextStyle(color: highlight)),
                                onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                                builder: (context) => const Profile()
                                        ),
                                ),
                        ),
                        ListTile(
                                leading: Icon(Icons.settings, color: highlight),
                                title: Text("Settings", style:TextStyle(color: highlight)),
                                onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                                builder: (context) => const SettingsPage()
                                        ),
                                ),
                        ),
                ];
        }

        Widget pages(Widget page, BuildContext context) {
                final colorTheme = AdaptiveTheme.of(context).mode;
                return Container(
                        color: switch (colorTheme) {
                                AdaptiveThemeMode.dark => const Color(0xFF4A4659),
                                _                      => const Color(0xFFFFFFFF),
                        },
                        child: page,
                );
        }

        // TODO: implement notifications from the app
        @override
        Widget build(BuildContext context) {
                AdaptiveThemeMode colorTheme = AdaptiveTheme.of(context).mode;
                return Scaffold(
                        appBar: appBar(_selectedIndex, colorTheme),
                        drawer: Drawer(
                                backgroundColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => const Color(0xFF453B61),
                                        _                      => const Color(0xFFFFFFFF),
                                },
                                child: ListView(
                                        padding: EdgeInsets.zero,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: drawerList(context),
                                ),
                        ),
                        body: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (int index) {
                                        pageChanged(index);
                                },
                                children: <Widget>[
                                        pages(const Home(), context),
                                        pages(const Categories(), context),
                                        pages(const Profile(), context),
                                        pages(const SettingsPage(), context),
                                ],
                        ),
                        bottomNavigationBar: BottomNavigationBar(
                                backgroundColor: const Color(0xFF5F5286),
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
                        floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
                                onPressed: () async {
                                        await showDialog<void>(
                                                context: context,
                                                builder: (_) => const InputForm(),
                                        );
                                },
                                backgroundColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => Color.alphaBlend(const Color(0xFFACACAC), Color(backgroundColor)),
                                        _                      => Color.alphaBlend(const Color(0xFFFFFFFF), Color(backgroundColor)),
                                },
                                hoverColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => const Color(0xFF919191),
                                        _                      => const Color(0xFFAAAAAA),
                                },
                                child: const Icon(Icons.add_outlined),
                        ) : const SizedBox(),
                );
        }
}

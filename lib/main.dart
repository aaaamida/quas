import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'tasks.dart';
import 'calen.dart';
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
                return ChangeNotifierProvider(
                        create: (context) => TaskProvider(),
                        child: AdaptiveTheme(
                                light: ThemeData.light(useMaterial3: true),
                                dark: ThemeData.dark(useMaterial3: true),
                                initial: AdaptiveThemeMode.dark,
                                builder: (theme, darkTheme) => MaterialApp(
                                        title: "QuAs",
                                        theme: ThemeData(
                                                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5F5286)),
                                                useMaterial3: true,
                                                fontFamily: "Nunito"
                                        ),
                                        home: const MyHomePage(),
                                        debugShowCheckedModeBanner: false,
                                ),
                        )
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
        // ignore: prefer_final_fields
        int _selectedIndex = 0;
        // ignore: prefer_final_fields
        PageController _pageController = PageController(
                initialPage: 0,
                keepPage: true,
        );
        late DateTime taskDeadline = DateTime.now();

        @override
        void initState() {
                super.initState();
        }

        void _pageChanged(int index) {
                setState(() {
                        _selectedIndex = index;
                });
        }

        void _barItemTapped(int index) {
                setState(() {
                        _selectedIndex = index;
                        _pageController.jumpToPage(index);
                });
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
                                icon: Icon(Icons.calendar_month_outlined),
                                activeIcon: Icon(Icons.calendar_month),
                                tooltip: "See tasks by day of the month",
                                label: "Calendar",
                        ),
                ];
        }


        PreferredSizeWidget _appBar(int page, AdaptiveThemeMode colorTheme, BuildContext context) {
                PreferredSizeWidget bar = switch (page) {
                        0 || 1 => AppBar(
                                title: Text(
                                        "QuAs",
                                        style: TextStyle(
                                                color: Color(switch (AdaptiveTheme.of(context).mode) {
                                                        AdaptiveThemeMode.dark => 0xFFFFFFFF,
                                                        _                      => 0xFF5F5286,
                                                }),
                                                fontFamily: "Yuruka",
                                                fontSize: 20)
                                ),
                                backgroundColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => const Color(0xFF5F5286),
                                        _                      => const Color(0xFFFFFFFF),
                                }
                        ),
                        _ => const PreferredSize(preferredSize: Size(24, 24), child: SizedBox(height: 24, width: 24)),
                };
                return bar;
        }

        List<Widget> _drawerList(BuildContext context) {
                final highlight = switch (AdaptiveTheme.of(context).mode) {
                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                        _                      => const Color(0xFF000000),
                };

                return <Widget>[
                        const DrawerHeader(
                                decoration: BoxDecoration(color: Color(0xFF5F5286)),
                                child: Text("QuAs", style: TextStyle(fontSize: 24, color: Color(0xFFFFFFFF), fontFamily: "Yuruka")),
                        ),
                        ListTile(
                                leading: Icon(Icons.account_circle, color: highlight),
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

        Widget _pages(Widget page, BuildContext context) {
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
                        appBar: _appBar(_selectedIndex, colorTheme, context),
                        drawer: Drawer(
                                backgroundColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => const Color(0xFF453B61),
                                        _                      => const Color(0xFFFFFFFF),
                                },
                                child: ListView(
                                        padding: EdgeInsets.zero,
                                        children: _drawerList(context),
                                ),
                        ),
                        body: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (int index) {
                                        _pageChanged(index);
                                },
                                children: <Widget>[
                                        _pages(const Home(), context),
                                        _pages(Calendar(taskDeadline: taskDeadline,), context),
                                        _pages(const Profile(), context),
                                        _pages(const SettingsPage(), context),
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
                                        _barItemTapped(index);
                                },
                        ),
                        floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
                                onPressed: () async {
                                        await showDialog<void>(
                                                context: context,
                                                builder: (_) => const InputForm(),
                                        );
                                },
                                backgroundColor: const Color(0xFFFFFFFF),
                                hoverColor: switch (colorTheme) {
                                        AdaptiveThemeMode.dark => const Color(0xFF919191),
                                        _                      => const Color(0xFFAAAAAA),
                                },
                                child: const Icon(Icons.add_outlined),
                        ) : const SizedBox(),
                );
        }
}

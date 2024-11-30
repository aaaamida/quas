import 'package:flutter/material.dart';
import 'enums.dart';
import 'home.dart';
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
                        home: const MyHomePage(),
                        debugShowCheckedModeBanner: false,
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
        AppTheme colorTheme = AppTheme.light;
        // ignore: prefer_final_fields
        PageController _pageController = PageController(
                initialPage: 0,
                keepPage: true,
        );

        @override
        void initState() {
                super.initState();
        }

        List<BottomNavigationBarItem> bottomBarItems() {
                return const [
                        BottomNavigationBarItem(
                                icon: Icon(Icons.home_outlined),
                                activeIcon: Icon(Icons.home),
                                tooltip: "Move to home page",
                                label: "Home",
                        ),
                        BottomNavigationBarItem(
                                icon: Icon(Icons.bookmark_add_outlined),
                                activeIcon: Icon(Icons.bookmark_add),
                                tooltip: "Add or remove tasks",
                                label: "Tasks",
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
                        _pageController.jumpToPage(index);
                });
        }

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
                        body: PageView(
                                controller: _pageController,
                                onPageChanged: (int index) {
                                        pageChanged(index);
                                },
                                children: <Widget>[
                                        Home(),
                                        Categories(),
                                        Profile(),
                                ],
                        ),
                        // ignore: prefer_const_constructors
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
                        )
                );
        }
}

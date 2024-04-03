import 'package:asmaul_husna/bookmark/bookmark_page.dart';
import 'package:asmaul_husna/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Color(0xffffb6b9)),
        cardTheme: const CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff8ac6d1),
          title: const Row(
            children: [
              Image(
                image: AssetImage('assets/images/ic_logo.png'),
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Asmaul Husna",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          bottom: setTabBar(),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            HomePage(),
            BookmarkPage(),
          ],
        ),
      ),
    );
  }

  TabBar setTabBar() {
    return TabBar(
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black26,
        indicatorColor: Colors.white,
        tabs: const [
          Tab(
            text: "Home",
            icon: Icon(Icons.menu_book),
          ),
          Tab(
            text: "Bookmark",
            icon: Icon(Icons.bookmarks_outlined),
          ),
        ],
    );
  }
}

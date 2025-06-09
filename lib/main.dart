// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/util/theme_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // intialize hive
  await Hive.initFlutter('hive_box');
  var box = await Hive.openBox('mybox');
  await Hive.openBox('settingsBox');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ThemeManager themeManager;

  @override
  void initState() {
    super.initState();
    themeManager = ThemeManager();
    themeManager.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',

      //  light mode and dark mode - - -  -

      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.yellow[200],
        appBarTheme: AppBarTheme(backgroundColor: Colors.yellowAccent),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.yellow,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey[800],
        ),
      ),
      themeMode: themeManager.currentTheme,
      home: HomePage(
        themeManager: themeManager,
      ),
    );
  }
}

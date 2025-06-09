import 'package:flutter/material.dart';
import 'package:todoapp/pages/home_page.dart';

import 'package:hive_flutter/hive_flutter.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element
// ignore_for_file: sort_child_properties_last

void main() async {
  // intialize hive
  await Hive.initFlutter('hive_box');
  var box = await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.yellow),
    );
  }
}

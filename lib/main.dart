import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/categories_page.dart';
import 'package:wallpaper_app/views/screens/home.dart';
import 'package:wallpaper_app/views/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wallpaper Studio',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

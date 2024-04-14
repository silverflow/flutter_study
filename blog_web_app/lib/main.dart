import 'package:blog_web_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

// HomeScreen in MaterialApp
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Blog Web App',
    home: HomeScreen(),
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/screens/screen_detail.dart';
import 'package:flutter_shopping_mall/screens/screen_index.dart';
import 'package:flutter_shopping_mall/screens/screen_login.dart';
import 'package:flutter_shopping_mall/screens/screen_register.dart';
import 'package:flutter_shopping_mall/screens/screen_search.dart';
import 'package:flutter_shopping_mall/screens/screen_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping mall',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/index': (context) => IndexScreen(),
        '/register': (context) => RegisterScreen(),
        // '/search': (context) => SearchScreen(),
        // '/detail': (context) => DetailScreen(),
      },
      initialRoute: '/',
    );
  }
}

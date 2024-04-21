import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // created pageController
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      int nextPage = pageController.page!.toInt() + 1;
      if (nextPage == 5) {
        nextPage = 0;
      }
      pageController.animateToPage(nextPage,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: PageView(
          controller: pageController,
          children: [1, 2, 3, 4, 5]
              .map((e) => Image.asset(
                    'asset/img/image_$e.jpeg',
                    fit: BoxFit.contain,
                  ))
              .toList(),
        ));
  }
}

// lib/screens/first_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_basic_01/screens/second_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is First Screen'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SecondScreen()));
                },
                child: Text('Go to Second Screen'))
          ],
        )));
  }
}

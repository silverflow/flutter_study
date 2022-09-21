// lib/screens/second_screen.dart
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is First Screen'),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go to First Screen'))
          ],
        )));
  }
}

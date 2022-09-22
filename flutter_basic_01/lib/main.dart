import 'package:flutter/material.dart';
import 'package:flutter_basic_01/screens/first_screen.dart';
import 'package:flutter_basic_01/screens/counter.dart';

void main() {
  runApp(MyApp());
}

// commit Test
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Counter(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  List<Widget> myChildren = [];
  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < 50; i++) {
    //   myChildren.add(Text('Hello, World!', style: TextStyle(fontSize: 25)));
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {}, child: Text('Text button')),
            Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(onPressed: () {}, child: Text('Elevated Button')),
            Padding(padding: EdgeInsets.all(20)),
            OutlinedButton(onPressed: () {}, child: Text('Outlined Button')),
            Padding(padding: EdgeInsets.all(20)),
            IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          ],
        ),
      ),
    );
  }
}

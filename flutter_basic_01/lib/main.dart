import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

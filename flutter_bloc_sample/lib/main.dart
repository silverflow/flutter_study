import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/blocs/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc_sample/screens/screen_counter.dart';
import 'package:flutter_bloc_sample/screens/screen_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterBloc(),
        child: MaterialApp(
          title: 'Flutter State Bloc',
          routes: {
            '/': (context) => HomeScreen(),
            '/counter': (context) => CounterScreen()
          },
          initialRoute: '/',
        ));
  }
}

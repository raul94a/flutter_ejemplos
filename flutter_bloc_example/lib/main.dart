import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/counter/counter_bloc.dart';
import './counter/counter_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Bloc demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CounterPage()
      ),
    );
  }
}

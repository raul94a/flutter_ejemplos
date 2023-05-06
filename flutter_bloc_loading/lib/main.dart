import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_loading/dogs/dogs_bloc.dart';
import 'package:flutter_bloc_loading/dogs/dogs_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogsBloc(),
      child: const MaterialApp(
        home: DogScreen()
      ),
    );
  }
}

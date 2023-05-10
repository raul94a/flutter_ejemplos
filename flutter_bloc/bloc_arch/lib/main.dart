import 'package:bloc_arch/views/characters/bloc/characters_bloc.dart';
import 'package:bloc_arch/views/characters/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (c) => CharactersBloc())],
      child: const MaterialApp(home: CharactersScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_theming/settings_bloc/settings_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: Builder(builder: (materialAppContext) {
        final isLightTheme = materialAppContext
            .select<SettingsBloc, bool>((value) => value.state.lightTheme);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isLightTheme ? ThemeData.light() : ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Change Theme with flutter_bloc!'),
              actions: [
                IconButton(
                    onPressed: () {
                      materialAppContext
                          .read<SettingsBloc>()
                          .add(ChangeThemeEvent());
                    },
                    icon:
                        Icon(isLightTheme ? Icons.light_mode : Icons.dark_mode))
              ],
            ),
            body: const Center(
              child: Text('Hello World!'),
            ),
          ),
        );
      }),
    );
  }
}

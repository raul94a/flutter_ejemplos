import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_theming/preferences/shared_preferences_helper.dart';

class SettingsState {
  final bool lightTheme;
  const SettingsState({this.lightTheme = true});

  SettingsState copyWith({
    bool? lightTheme,
  }) {
    return SettingsState(
      lightTheme: lightTheme ?? this.lightTheme,
    );
  }
}

abstract class SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferencesHelper preferences;
  //by default light theme is TRUE
  SettingsBloc({required this.preferences})
      : super(SettingsState(lightTheme: preferences.getTheme())) {
    on<ChangeThemeEvent>(_changeTheme);
  }

  Future<void> _changeTheme(ChangeThemeEvent event, Emitter emit) async {
    final isLightTheme = state.lightTheme;
    preferences.setTheme(!isLightTheme);
    emit(state.copyWith(lightTheme: !isLightTheme));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferencesHelper.init();
  runApp(MainApp(preferences: preferences));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.preferences});

  final SharedPreferencesHelper preferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(preferences: preferences),
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

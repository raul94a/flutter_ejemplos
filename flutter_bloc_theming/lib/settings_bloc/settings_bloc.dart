// ignore_for_file: public_member_api_docs, sort_constructors_first
//1. State
//2. Events
//3. Bloc

import 'package:flutter_bloc/flutter_bloc.dart';

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
  final bool lightTheme;
  //by default light theme is TRUE
  SettingsBloc({this.lightTheme = true})
      : super(SettingsState(lightTheme: lightTheme)) {
    on<ChangeThemeEvent>(_changeTheme);
  }

  _changeTheme(ChangeThemeEvent event, Emitter emit) {
    final isLightTheme = state.lightTheme;
    emit(state.copyWith(lightTheme: !isLightTheme));
  }
}

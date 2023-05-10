//State
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class DogState {
  final String dogImage;
  final bool loading;
  final bool error;
  DogState({
    required this.dogImage,
    required this.error,
    required this.loading,
  });

  DogState copyWith({
    String? dogImage,
    bool? loading,
    bool? error,
  }) {
    return DogState(
      dogImage: dogImage ?? this.dogImage,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

//Events

abstract class DogEvent {}

class FetchImageEvent extends DogEvent {
  FetchImageEvent();
}

class TriggerErrorEvent extends DogEvent {}

class ClearErrorEvent extends DogEvent{}

//Bloc
class DogsBloc extends Bloc<DogEvent, DogState> {
  DogsBloc() : super(DogState(dogImage: '', error: false, loading: false)) {
    on<FetchImageEvent>(_fetchDogImage);
    on<TriggerErrorEvent>(_triggerError);
    on<ClearErrorEvent>(_clearError);
  }

  Future<void> _fetchDogImage(FetchImageEvent event, Emitter emit) async {
    emit(state.copyWith(loading: true));
    //let's make an artificial delay. The target of that is to show the circurlar
    //progress indicator in the loading state for longer
    await Future.delayed(const Duration(seconds: 1));
    try {
      //Fetch the dog image. You usually set up a Repository that manage the access
      //to the data.
      final uri = Uri.parse('https://dog.ceo/api/breeds/image/random');
      final response = await get(uri);
      final jsonResponse = jsonDecode(response.body);
      final image = jsonResponse['message'];
      emit(state.copyWith(loading: false, error: false, dogImage: image));
    } catch (exception) {
      emit(state.copyWith(error: true, loading: false));
    }
  }

  _triggerError(TriggerErrorEvent event, Emitter emit) {
    emit(state.copyWith(loading: false, error: true));
  }
  _clearError(ClearErrorEvent event, Emitter emit){
    emit(state.copyWith(error: false));
  }
}
